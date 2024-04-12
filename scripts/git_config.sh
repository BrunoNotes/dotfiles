#!/bin/bash

test=$(whoami)

read -p "Name: " name_q
read -p "Email: " email_q

git config --global user.name "$name_q"
git config --global user.email "$email_q"
