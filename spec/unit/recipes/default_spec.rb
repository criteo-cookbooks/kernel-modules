# This file is auto-generated by the code_generator (one-time action)
#
# Cookbook Name:: kernel-modules
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'kernel-modules::default' do
  shared_examples_for :default do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'sets the correct packages' do
      expected_packages =
        case chef_run.node['platform_version'].to_i
        when 6
          %w[initscripts module-init-tools]
        when 7..8
          %w[systemd kmod]
        when 9
          %w[systemd-udev kmod]
        end
      expect(chef_run.node['kernel_modules']['packages']).to eq(expected_packages)
    end

    it 'sets the correct modules_load.d directory path' do
      expected_path =
        case chef_run.node['platform_version'].to_i
        when 6
          '/etc/sysconfig/modules'
        when 7..9
          '/etc/modules-load.d'
        end
      expect(chef_run.node['kernel_modules']['modules_load.d']).to eq(expected_path)
    end
  end

  platforms.each do |platform, versions|
    versions.each do |version|
      context "When all attributes are default, on #{platform} #{version}" do
        cached(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform.to_s, version: version) do
            # Nothing to do here folks
          end.converge(described_recipe)
        end

        it_behaves_like :default
      end
    end
  end
end
