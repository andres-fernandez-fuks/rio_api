module Persistence
  module Repositories
    class TaskRepository
      def all
        tasks
      end

      def save(task)
        if task.id.nil?
          task.id = tasks.size
          tasks << task
        else
          tasks[task.id] = task
        end

        task
      end

      def find(id)
        find_record_by_id(id).clone
      end

      def delete_all
        tasks.clear
      end

      def delete(task)
        tasks.delete_at(task.id)
      end

      private

      def find_record_by_id(id)
        task = tasks[id]
        raise TaskNotFound, "Task with id [#{id}] not found" if task.nil?

        task
      end

      def tasks
        @@tasks ||= []
      end
    end
  end
end
