#
# spec file for package rubygem-libyui_client
#
# Copyright (c) 2020 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#

Name:           rubygem-libyui_client
Version:        0.4.0
Release:        0
%define mod_name libyui_client
%define mod_full_name %{mod_name}-%{version}
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildRequires:  ruby-macros >= 5
BuildRequires:  %{ruby >= 2.5.0}
BuildRequires:  %{rubygem gem2rpm}
BuildRequires:  rubygem(%rb_default_ruby_abi:yast-rake)
Url:            https://github.com/qa-sle-yast/libyui_client
Source:         https://rubygems.org/gems/%{mod_full_name}.gem
Summary:        Client for libyui applications
License:        MIT
Group:          Development/Languages/Ruby

%description
Client to operate controls for libyui applications.

%prep

%build

%install
%gem_install \
  --doc-files="LICENSE.txt README.md" \
  -f

%gem_packages

%changelog
