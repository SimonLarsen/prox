local StateMachine = class("prox.fsm.StateMachine")

function StateMachine:initialize()
	self._current = nil

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
	if self._current == nil then return end
	assert(self._states[self._current], string.format("State \"%s\" does not exist.", self._current))

	if self._states[self._current].update then
		self._states[self._current].update(...)
	end
end

function StateMachine:addTransition(from, to, fun)
	assert(self._states[from], string.format("State \"%s\" does not exist.", from))
	assert(self._states[to], string.format("State \"%s\" does not exist.", to))

	self._states[from].transitions[to] = fun
end

function StateMachine:update(...)
	if self._current then
		local new_state = self._update[self._current](...)
	end

	if new_state then
		self:setState(state)
	end
end

function StateMachine:setState(state)
	assert(self._states[state], string.format("State \"%s\" does not exist.", state))
	if state == self._current then return end

	if self:currentState() then
		if self:currentState().leave then
			self:currentState().leave()
		end

		if self:currentState().transitions[state] then
			self:currentState().transitions[state]()
		end
	end

	self._current = state
	if self:currentState().enter then
		self:currentState().enter()
	end
end

function StateMachine:currentState()
	return self._states[self._current]
end

return StateMachine
