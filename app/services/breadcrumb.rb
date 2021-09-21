class Breadcrumb
  def add_breadcrumbs(url)
    binding.pry
    path = url.split('/')
    path.drop(3).each do |route|
      add_breadcrumb "my", :"#{route}_path" if route.to_i.zero?
    end
  end
end