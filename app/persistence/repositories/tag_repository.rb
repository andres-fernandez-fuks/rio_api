module Persistence
  module Repositories
    class TagRepository
      def all
        tags
      end

      def save(tag)
        if tag.id.nil?
          tag.id = tags.size
          tags << tag
        else
          tags[tag.id] = tag
        end

        tag
      end

      def find(id)
        find_record_by_id(id).clone
      end

      def find_by_tag_name(name, &when_not_found)
        tag = tags.find { |t| t.tag_name == name }
        return tag unless tag.nil?

        when_not_found.call
      end

      def delete_all
        tags.clear
      end

      def delete(tag)
        tags.delete_at(tag.id)
      end

      private

      def find_record_by_id(id)
        tag = tags[id]
        raise TagNotFound, "Tag with id [#{id}] not found" if tag.nil?

        tag
      end

      def tags
        @@tags ||= []
      end
    end
  end
end
