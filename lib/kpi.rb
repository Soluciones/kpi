require "kpi/engine"

module Kpi
  class Engine < Rails::Engine
    isolate_namespace Kpi
  end
end
