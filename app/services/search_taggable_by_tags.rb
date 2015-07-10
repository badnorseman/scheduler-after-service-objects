class SearchTaggableByTags
  def initialize(tag_list:)
    @tags = tag_list.split(", ")
  end

  def call
    Tagging.select(:taggable_id, :taggable_type).
            joins(:tag).
            where(tags: { name: @tags } ).
            group(:taggable_id, :taggable_type).
            having("COUNT(taggable_id) = #{@tags.count}").
            collect(&:taggable)
  end
end
