class BaseService
  def execute
    ApplicationRecord.transaction do
      begin
        _execute
      rescue Exception => e
        rollback
        raise e
      end
    end
  end

  private

  # To be implemented in subclasses
  # :nocov:
  def _execute
    raise NotImplementedError
  end
  # :nocov:

  # To be implemented in subclasses if needed. I
  # Rollback changes other than DB changes (like API calls that modifies something)
  def rollback
  end

end
