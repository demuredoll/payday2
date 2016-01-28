Hooks:PostHook(HUDTeammate, "init", "killcounter_hudteammate_init", function(self, i, teammates_panel)
  local kill_counter_name = "kill_counter_" .. i
  local teammate_panel = teammates_panel:child("" .. i)

  if teammates_panel:child(kill_counter_name) then
    teammates_panel:remove(teammates_panel:child(kill_counter_name))
  end

  self._kill_counter = self._hud_panel:panel({
    name = kill_counter_name,
    visible = true,
    w = teammate_panel:w(),
    h = KillCounter.height,
    x = 0,
    halign = "right"
  })

  self._kill_icon = self._kill_counter:bitmap({
    layer = 1,
    name = "kill_icon",
    texture = "guis/textures/pd2/risklevel_blackscreen",
    w = self._kill_counter:h(),
    h = self._kill_counter:h(),
    blend_mode = KillCounter.blend_mode,
    color = Color(KillCounter.color)
  })

  self._kill_text = self._kill_counter:text({
    layer = 2,
    name = "kill_text",
    text = "0/0",
    w = self._kill_counter:w() - self._kill_icon:w(),
    h = self._kill_counter:h(),
    align = "right",
    vertical = "center",
    color = Color(KillCounter.color),
    font = "fonts/font_medium_mf",
    font_size = self._kill_counter:h()
  })

  self._kill_counter.set_righttop(teammate_panel:right(), teammate_panel:bottom())
end)

function HUDTeammate:update_kill_counter(headshot, total)
  self._kill_text:set_text(headshot .. "/" .. total)

  local _, _, w, _ = self._kill_text:text_rect()

  self._kill_icon:set_right(self._kill_counter:w() - w)
end