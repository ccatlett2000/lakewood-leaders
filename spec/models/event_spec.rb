require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'is valid with valid information' do
    event = Event.new(name: 'Event', description: 'Event description', location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29', end_time: '2016-07-01 23:57:29', finished: false, max_participants: 1)
    expect(event).to be_valid
  end

  it 'is not valid with a missing name' do
    event = Event.new(name: nil, description: 'Event description', location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29', end_time: '2016-07-01 23:57:29', finished: false, max_participants: 1)
    expect(event).not_to be_valid
  end

  it 'is not valid with a missing description' do
    event = Event.new(name: 'Event', description: nil, location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29', end_time: '2016-07-01 23:57:29', finished: false, max_participants: 1)
    expect(event).not_to be_valid
  end

  it 'is not valid with a missing location' do
    event = Event.new(name: 'Event', description: 'Event description', location: nil, start_time: '2016-07-01 23:57:29', end_time: '2016-07-01 23:57:29', finished: false, max_participants: 1)
    expect(event).not_to be_valid
  end

  it 'is not valid with a missing start time' do
    event = Event.new(name: 'Event', description: 'Event description', location: '1234 Street St. New York, USA', start_time: nil, end_time: '2016-07-01 23:57:29', finished: false, max_participants: 1)
    expect(event).not_to be_valid
  end

  it 'is not valid with a missing end time' do
    event = Event.new(name: 'Event', description: 'Event description', location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29', end_time: nil, finished: false, max_participants: 1)
    expect(event).not_to be_valid
  end

  it 'is not valid with an invalid description' do
    event = Event.new(name: 'Event', description: '0' * 2049, location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29', end_time: '2016-07-01 23:57:29', finished: false, max_participants: 1)
    expect(event).not_to be_valid
  end

  it 'is not valid with an invalid finished' do
    event = Event.new(name: 'Event', description: 'Event description', location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29', end_time: '2016-07-01 23:57:29', finished: nil, max_participants: 1)
    expect(event).not_to be_valid
  end

  it 'is not valid with a missing max participant' do
    event = Event.new(name: 'Event', description: 'Event description', location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29', end_time: '2016-07-01 23:57:29', finished: false, max_participants: nil)
    expect(event).not_to be_valid
  end

  it 'is not valid with too little participants' do
    event = Event.new(name: 'Event', description: 'Event description', location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29', end_time: '2016-07-01 23:57:29', finished: false, max_participants: 0)
    expect(event).not_to be_valid
  end
end
