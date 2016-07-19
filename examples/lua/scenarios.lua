#!/usr/bin/env lua

----------------------------------------------------------------------
-- This script presents how to run some scenarios.
-- Configuration is loaded from "../../examples/config/<SCENARIO_NAME>.cfg" file.
-- <episodes> number of episodes are played.
-- Random combination of buttons is chosen for every action.
-- Game variables from state and last reward are printed.
--
-- To see the scenario description go to "../../scenarios/README.md"
----------------------------------------------------------------------

require("vizdoom")

game = vizdoom.DoomGame()

-- Choose scenario config file you wish to watch.
-- Don't load two configs cause the second will overrite the first one.
-- Multiple config files are ok but combining these ones doesn't make much sense.

game:load_config("../../examples/config/basic.cfg")
--game:load_config("../../examples/config/deadly_corridor.cfg")
--game:load_config("../../examples/config/deathmatch.cfg")
--game:load_config("../../examples/config/defend_the_center.cfg")
--game:load_config("../../examples/config/defend_the_line.cfg")
--game:load_config("../../examples/config/health_gathering.cfg")
--game:load_config("../../examples/config/my_way_home.cfg")
--game:load_config("../../examples/config/predict_position.cfg")
--game:load_config("../../examples/config/take_cover.cfg")

-- Makes the screen bigger to see more details.
game:set_screen_resolution(vizdoom.ScreenResolution.RES_640X480)
game:init()

-- Creates all possible actions depending on how many buttons there are.
actions_num = game:get_available_buttons_size()
actions = {}
for i = 1, actions_num do
    actions[i] = {}
    for j = 1, actions_num do
        actions[i][j] = 0
        if i == j then actions[i][j] = 1 end
    end
end


episodes = 10
sleep_time = 28

for i = 1, episodes do

    print("Episode #" .. i)

    -- Not needed for the first episode but the loop is nicer.
    game:new_episode()
    while not game:is_episode_finished() do

        -- Gets the state and possibly to something with it
        s = game:get_state()

        -- Makes a random action and save the reward.
        r = game:make_action(actions[math.random(1,actions_num)])

        print("State # " .. s.number)
        print("Reward: " .. r)
        print("=====================")

        -- Sleep some time because processing is too fast to watch.
        if sleep_time > 0 then
            vizdoom.sleep(sleep_time)
        end
    end

    print("Episode finished.")
    print("total reward: " .. game:get_total_reward())
    print("************************")

end

game:close()
