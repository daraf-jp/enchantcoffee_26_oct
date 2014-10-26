#!/usr/bin/env ruby
require "rubygems"
require "git"

git = Git.open(Dir.pwd)
logs_sha = git.log.map(&:sha)

sha = logs_sha[0]
prev_sha = logs_sha[1]

diff = git.diff(sha, prev_sha)

diff.each do |file_diff|
  file_diff.patch.split("\n").each do |line|
    if /^\+/ =~ line
      puts "<span class='green'>#{line}</span>"
    end
  end
end

# logs_sha.each_with_index do |sha, i|
#   if logs_sha.length > i + 1
#     prev_sha = logs_sha[i + 1]
#     diff = git.diff(sha, prev_sha)

#     diff.each do |file_diff|
#       puts file_diff.blob(:src).contents
#     end
#   end
# end
