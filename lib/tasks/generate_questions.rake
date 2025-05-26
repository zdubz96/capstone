namespace :questions do
  desc "Generate structured quiz questions for each topic and difficulty (1–10)"
  task generate_structured: :environment do
    excluded_names = ["Math", "History"]
    Topic.where.not(topic: excluded_names).find_each do |topic|
      puts "📚 Generating questions for topic: #{topic.topic}"
      (1..10).each do |difficulty|
        puts "  ▶️ Difficulty level: #{difficulty}"
        saved_count = 0
        while saved_count<5
          recent_questions = Question.where(topic_id: topic.id)
                           .order(created_at: :desc)
                           .pluck(:question)
          
          fuzzy = FuzzyMatch.new(recent_questions)

          puts "    - Generating question #{saved_count + 1}/5..."

          chat = OpenAI::Chat.new
          chat.model = "gpt-4.1-nano"
          chat.system("You are a highly reliable quiz generator. You must return valid JSON objects matching the schema.")
          chat.schema = {
            name: "quiz_question",
            schema: {
              type: "object",
              properties: {
                question: {
                  type: "string",
                  description: "The actual question to present to the user."
                },
                options: {
                  type: "object",
                  properties: {
                    a: { type: "string" },
                    b: { type: "string" },
                    c: { type: "string" },
                    d: { type: "string" }
                  },
                  required: ["a", "b", "c", "d"],
                  additionalProperties: false
                },
                correct_option: {
                  type: "string",
                  enum: ["a", "b", "c", "d"],
                  description: "The key of the correct answer"
                },
                explanation: {
                  type: "string",
                  description: "Why the correct answer is right."
                },
                difficulty: {
                  type: "integer",
                  description: "Difficulty on a 1–10 scale"
                }
              },
              required: ["question", "options", "correct_option", "explanation", "difficulty"],
              additionalProperties: false
            },
            strict: true
          }.to_json

          chat.user("Generate a quiz question for the topic '#{topic.topic}' at difficulty level #{difficulty} on a scale from 1 (very easy) to 10 (very hard).  Avoid repeating similar ideas to these questions: #{recent_questions.map.with_index(1) { |q, i| "#{i}. #{q}" }.join("\n")}.Return a valid JSON object with the appropriate structure and difficulty.")

          result = chat.assistant!
          

          match, score = fuzzy.find_with_score(result["question"])

          if score && score > 0.8
            puts "❌ Skipped (Too similar to: #{match[0..60]}... with score #{score})"
            next
          end

          Question.create!(
            question: result["question"],
            options: result["options"],
            correct_option: result["correct_option"],
            explanation: result["explanation"],
            difficulty: difficulty,
            topic_id: topic.id
          )

          saved_count += 1

          puts "      ✅ Saved: #{result["question"][0..50]}..."


          sleep 1 # Respect rate limits
        end
      end
    end

    puts "🎉 All questions generated!"
  end
end
