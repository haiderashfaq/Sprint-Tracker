require 'will_paginate/view_helpers/link_renderer'
require 'will_paginate/view_helpers/action_view'
require 'will_paginate/array'

module WillPaginate
  module ActionView
    class LinkRenderer
      def link(text, target, attributes = {})
        attributes['data-remote'] = true
        super
      end
    end
  end
end
