require "redis"
require "../model/model"

# TODO: look into passing a class instead of an instance of a class
# and look deeper into crystal's generics and inheritance systems.

module RedisInterface
  extend self

  @@store

  def initialize
    @@store = Redis::PooledClient.new
  end

  def set(model : Model)
    REDIS.set("#{model.get_name}.#{model.get_id}", model)
  end

  def del(model : Model)
    REDIS.del("#{model.get_name}.${model.get_id}")
  end

  def filter(where, results) : Array(Model)
  end

  def get(where, model : Model) : Array(Model)
    name = model.get_name
    keys = REDIS.keys("#{name}.*")
    results : Array(Model)
    if keys.size > 0
      res = keys.map do |key|
        REDIS.get(key)
      end
      results = self.filter(where, res)
    end
    results
  end
end
