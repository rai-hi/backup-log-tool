# frozen_string_literal: true

require 'backup'
require 'date'

describe Backup do
  it_behaves_like 'Loggable'

  let(:created_at) do
    DateTime.now - 5
  end

  let(:status) { 'Completed' }
  let(:filesize) { '430MB' }
  let(:database_name) { 'DATABASE' }

  subject do
    build :backup, created_at: created_at, status: status
  end

  it 'returns the correct ID' do
    expect(subject.id).to eq('a810')
  end

  describe '.==' do
    it 'returns false if the id is different' do
      original = build :backup
      other = build :backup, id: 'not_same'
      expect(original == other).to be_falsy
    end

    it 'returns true if the id is the same' do
      other = build :backup, id: subject.id
      expect(subject == other).to be true
    end
  end

  it 'returns the correct created_at date' do
    expect(subject.created_at).to eq(created_at)
  end

  it 'returns the correct status, as a symbol' do
    expect(subject.status).to eq(status)
  end

  it 'returns the correct filesize' do
    expect(subject.filesize).to eq(filesize)
  end

  it 'returns the correct database name' do
    expect(subject.database_name).to eq(database_name)
  end

  it 'returns if it is older than a specifed time range' do
    expect(subject.older_than_days?(9999)).to be_falsy
  end

  it 'returns if it is older than a specifed time range' do
    expect(subject.older_than_days?(0)).to be_truthy
  end
end
