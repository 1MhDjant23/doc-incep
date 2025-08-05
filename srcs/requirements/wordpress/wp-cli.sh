#!/bin/bash

# How to install WP-CLI
https://wp-cli.org/
# command that provide a quick overview of wordpress site details
wp site info
# -----------------------
# command to create and generate posts and pages with content

wp post create --post_type=post --post_title="New Post"
wp post generate

# How To Create Users
wp user create
# e.g:
    wp user create djant djantmh12@gmail.com --role=editor

# How To Modify users

wp user update
# e.g:
    wp user update 12 --display_name='jhon'
    # ! "12" is djant ID

# How To delete a User
wp user delete
# e.g:
    wp user delete 12 --reassign=45
    # In this case, again "12" is djant's ID and "45" 
    #is the ID of the user you want to assign djant's 
    #content to (for example posts, pages, and so on).