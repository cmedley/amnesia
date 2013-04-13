Code.require_file "../test_helper.exs", __FILE__

defmodule AmnesiaTest do
  use ExUnit.Case
  use Amnesia

  test "transaction returns proper values" do
    assert(Amnesia.transaction do
      42
    end == { :atomic, 42 })

    assert(Amnesia.transaction do
      exit :doo
    end == { :aborted, :doo })
  end

  setup_all do
    :error_logger.tty(false)

    Amnesia.Schema.create
    Amnesia.start

    :ok
  end

  teardown_all do
    Amnesia.stop
    Amnesia.Schema.destroy

    :error_logger.tty(true)

    :ok
  end
end
