site :opscode

metadata

cookbook 'xfs'
cookbook 'ephemeral_lvm'
cookbook 'rs-machine_tag', github: 'rightscale-cookbooks/rs-machine_tag', ref: 'b487656521e4bf2a58a10856f29fcad35340b9bf'
cookbook 'collectd', github: 'EfrainOlivares/chef-collectd', ref: 'ec50609ed6eb193e0411f30aced91befa571940f'

group :integration do
  cookbook 'apt', '~> 2.3.0'
  cookbook 'yum', '~> 2.4.4'
end
