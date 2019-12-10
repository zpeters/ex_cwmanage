ExUnit.configure(exclude: [:live])
ExUnit.start()

Mox.defmock(ExCwmanage.Api.Mock, for: ExCwmanage.Api.Behaviour)
