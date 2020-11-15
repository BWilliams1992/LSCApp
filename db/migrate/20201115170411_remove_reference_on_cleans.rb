class RemoveReferenceOnCleans < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cleans, :clean_request
  end
end
