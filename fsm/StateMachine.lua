local Stack = require("prox.containers.Stack")

local StateMachine = class("prox.fsm.StateMachine")

local call_if_exists = function(fn, ...)
	if fn then
		return fn(...)
	end
end

function StateMachine:initialize()
	self._current = Stack()
	self._states = {}
end

function StateMachine:addState(state, update, enter, leave)
	self._states[state] = {
		update = update,
		enter = enter,
		leave = leave,
		transitions = {}
	}
end

function StateMachine:update(...)
	if self._current:isEmpty() then return end
	assert(self:currentState(), string.format("State \"%s\" does not exist.", self:currentState()))

	call_if_exists(self:currentState().update, ...)
end

function StateMachine:addTransition(from, to, fun)
	assert(self._states[from], string.format("State \"%s\" does not exist.", from))
	assert(self._states[to], string.format("State \"%s\" does not exist.", to))

	self._states[from].transitions[to] = fun
end

function StateMachine:setState(state)
	assert(self._states[state], string.format("State \"%s\" does not exist.", state))

	if self:currentState() then
		call_if_exists(self:currentState().leave)
		call_if_exists(self:currentState().transitions[state])

		self._current:pop()
	end

	self._current:push(state)

	call_if_exists(self:currentState().enter)
end

function StateMachine:pushState(state)
	assert(self._states[state], string.format("State \"%s\" does not exist.", state))

	if self:currentState() then
		call_if_exists(self:currentState().leave)
		call_if_exists(self:currentState().transitions[state])
	end

	self._current:push(state)

	call_if_exists(self:currentState().enter)
end

function StateMachine:popState()
	assert(self:currentState(), "Cannot pop empty StateMachine.")

	call_if_exists(self:currentState().leave)

	local old_state = self:currentState()

	self._current:pop()
	if not self._current:isEmpty() then
		call_if_exists(old_state.transitions[self._current:pop()])
	end

	call_if_exists(self:currentState().enter)
end

function StateMachine:currentState()
	return self._states[self._current:peek()]
end

return StateMachine
