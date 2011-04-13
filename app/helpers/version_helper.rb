module VersionHelper
  def revert version_id
    begin
      version = Version.find(version_id)

      raise unless version.next.nil?

      if version.reify
        version.reify.save!
      else
        version.item.destroy
      end

      version
    rescue
      nil
    end
  end
end