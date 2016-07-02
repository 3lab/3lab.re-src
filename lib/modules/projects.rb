require 'yaml'
require 'fileutils'

module Projects
  class << self
    attr_accessor :list
  end

  class Project
    attr_accessor :name, :link, :source, :description
    def initialize(params = {})
      @name = params.fetch(:name, 'unknown')
      @description = params.fetch(:description, nil)
      @link = params.fetch(:link, 'http://git.3lab.re/' + @name)
      @source = params.fetch(:repositories, 'http://git.3lab.re/' + @name)
    end
  end

  def Projects.hash_to_project(projecthash)
    Project.new(
        name: projecthash['name'],
        description: projecthash['description'],
        link: projecthash['link'],
        source: projecthash['source'],
    )
  end

  def Projects.load_projects
    projects_arr = []
    path = File.dirname(__FILE__).split('/')[0..-3].join('/') + '/source/projects/*.yml'
    Dir[path].each do |project_path|
      projects_arr << Projects.hash_to_project((YAML.load_file(project_path)))
    end
    self.list = projects_arr
  end
end

Projects.load_projects