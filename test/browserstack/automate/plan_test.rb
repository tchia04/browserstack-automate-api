# frozen_string_literal: true

require './test/test_helper'

class Browserstack::Automate::ApiTest::Plan < Minitest::Test
  def test_it_does_something_useful
    assert true
  end

  def test_exists
    assert Browserstack::Automate::ApiTest::Plan
  end
end
