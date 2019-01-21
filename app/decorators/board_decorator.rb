module BoardDecorator
  def format_created_at
    self.created_at.strftime('%Y年%m月%d日 %H:%M:%S')
  end
end
