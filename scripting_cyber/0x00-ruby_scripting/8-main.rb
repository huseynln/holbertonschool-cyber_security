#!/usr/bin/env ruby

require_relative '8-post'

url = 'https://jsonplaceholder.typicode.com/posts'
body_params = {}
post_request(url, body_params)
