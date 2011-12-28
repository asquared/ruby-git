#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../test_helper'

class TestHashObject < Test::Unit::TestCase

  def setup
    set_file_paths
    @git = Git.open(@wdir)
  end
  
  def test_hash_file
    
    in_temp_dir do
      g = Git.clone(@wbare, 'test')

      File.open('test_file', 'w') do |f|
        f.write('asdfasdf')
      end

      hash = g.hash_file(File.expand_path('test_file'))

      # from git-hash-object
      assert(hash == '23a3a9d599131d7f61b7383e5814c63e63ed186d') 
      # make sure file was created in repository
      assert(g.cat_file(hash) == 'asdfasdf');
    end
  end

end
