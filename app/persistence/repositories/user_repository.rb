module Persistence
  module Repositories
    class UserRepository
      def all
        users
      end

      def find(id)
        find_record_by_id(id).clone
      end

      def save(user)
        if user.id.nil?
          user.id = users.size
          users << user
        else
          users[user.id] = user
        end

        user
      end

      def delete(user)
        users.delete_at(user.id)
      end

      def delete_all
        users.clear
      end

      private

      def find_record_by_id(id)
        user = users[id]
        raise UserNotFound, "User with id [#{id}] not found" if user.nil?

        user
      end

      def users
        @@users ||= []
      end
    end
  end
end
