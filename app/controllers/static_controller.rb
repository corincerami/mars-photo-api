class StaticController < ApplicationController
  def explore
    render file: Rails.root.join('public', 'assets', 'frontend', 'index.html'), layout: false
  end
end
