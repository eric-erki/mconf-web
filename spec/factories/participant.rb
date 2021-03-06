# This file is part of Mconf-Web, a web application that provides access
# to the Mconf webconferencing system. Copyright (C) 2010-2015 Mconf.
#
# This file is licensed under the Affero General Public License version
# 3 or later. See the LICENSE file.

FactoryGirl.define do
  factory :participant, :class => Participant do |e|
    e.email { owner.present? ? owner.email : Forgery::Internet.email_address }
    e.association :event
    e.association :owner, factory: :user
  end
end
