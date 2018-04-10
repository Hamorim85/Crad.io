# frozen_string_literal: true

# Removing nodes
p 'Removing nodes...'
Node.destroy_all

p 'Adding nodes...'
Node.create(name: 'Coca-Cola', url: 'cocacola')
