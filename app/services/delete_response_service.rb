class DeleteResponseService
  def initialize response
    @response = response
  end

  def call
    destroy_response
  end

  private
  attr_reader :response

  def destroy_response
    response.destroy!
  end
end