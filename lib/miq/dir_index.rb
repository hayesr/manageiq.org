require "jekyll"

module Miq
  class DirIndex < Jekyll::Page
    # Initialize a new Directory Index.
    #
    # site - The Site object.
    # base - The String path to the source.
    # dir  - The String path between the source and the file.
    def initialize(site, dir, pages = [])
      @site = site
      @base = Miq.site_dir
      @dir  = dir
      @name = "index.html"
      @path = File.join(@base, "_layouts", Miq.index_template)

      process(name)
      read_yaml(File.join(@base, "_layouts"), Miq.index_template)

      data.default_proc = proc do |_, key|
        site.frontmatter_defaults.find(File.join(dir, name), type, key)
      end

      data['pages'] = pages

      Jekyll::Hooks.trigger :pages, :post_init, self
    end
  end
end
