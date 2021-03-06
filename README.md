# tw-needs-hook
_Filtering based on needs-level/ importance_

    Status: Working well, still under testing
    
    CAVEAT: Without much error-checking, and only tested by one person (hint)
    Back up your data (like always) and give this a whirl. If you like the idea,
    pitch in!

    See also: needs.txt help file, for requirements, installation, config, etc.
----
The needs-hierarchy extension for taskwarrior is based on a theory proposed by Abraham Maslow in his 1943 paper "A Theory of Human Motivation". see wikipedia: http://en.wikipedia.org/wiki/Maslow%27s_hierarchy_of_needs. Never heard of it? or heard of it and don't think it applies to you? KEEP READING! 

When you are adding a new task, ask yourself the question "why do I need to do this task? What need-level does it serve?" and assign a need:1-6.

The levels correspond to these universal human needs;

1. Physiological; air, water, food, shelter & medical
    -- These are things you need to be a living organism
2. Personal safety, security, health, financial
    -- A roof over your head, keep your job, heating, food in the fridge
3. Love & belonging, friends & family
    -- The things you need to do in order to have friends and a family
4. Esteem, respect & recognition
    -- Inventions, art-works, play music, get a degree
5. Self actualization
    -- Decide where and how you live, express the things you want to express
6. Higher goals
    -- Big things you want to do with your life

Tracking tasks by needs-level also relates to GTD(tm) Levels of Focus and to goal-setting, in general. As the needs-level increases, the related activities become loftier, with higher purpose. 

The target-audience for this extension is taskwarrior users who want to keep track of _everything_ but then to avoid being distracted by a huge list of non-critical tasks, until the most basic needs are met. On the other side of the spectrum, Mazlow mode is also life-goal tracking mode.

### How it works

#### need UDA
A new UDA (User Defined Attribute) is defined, with constrained (string) values 1 - 6

The "need:" uda would be considered "required" (for this method to be effective) and a value should be assigned to all tasks. Occasionally running `check_needs.sh` will assign the default `need:4` to any +PENDING task without a set need level. 

Assign a value like any other uda;

    task 142 mod need:3

#### needs command
A new command "needs" (the plural) is used to control the filtering, and to report on needs status.

    task needs
with no other arguments, invokes the needs report, which indicates the current lowest level need,
the number of tasks in each need-level, and handy reference, a reminder about what each level means.
<pre>
    6      /              Higher Goals                \      (2)
    5     /            Self Actualization              \     (2)
    4    /       Esteem, Respect & Recognition          \   (17)
    3   /      Love & Belonging, Friends & Family        \  (32)
 -->2  /   Personal safety, security, health, financial   \  (2)
    1 /     Physiological; Air, Water, Food & Shelter      \ (0)
</pre>
To limit the filtering to a specified level (for example, for everything up to and including 3)

    task needs 3
sets the need-hierarchy-level to "3", which is equivalent to 'need <= 3' and applies that to a persistant filter (like context) that will affect all task listings untill it is cleared or changed.
At this setting, only tasks with need:1 to need:3 will be shown in normal lists.

    task needs auto
engages an automatically set level based on the lowest (most important) level found. This is the real "magic" part, where the task-needs-hierarchy (when fully engaged) self-imposes list filtering, showing the most basic (most important) needs. If you have 2 tasks with need:2 (Safety/ Security, like the mockup report above) then nothing but need:2 tasks will be listed. Once you complete all of the need:2 level tasks, the next level becomes visible (need:3, Friendship/ Family) and so on.

    task needs 0
is used to turn off all needs-herarchy filtering, end "Mazlow Mode".

#### Objective

1. describe this extension well enough to be compelling to a programmer, that it is implemented
2. implement a proof-of-concept
3. make extension easily installable for normal taskwarrior users (maybe pirate hook?)
4. promote extension
5. improve extension
6. see taskwarrior users take control of the most important tasks, first.

#### Outcomes

"Mazlow mode" might also be called "Most Important Tasks" mode, or "Responsibility mode". We might all have Higher Goals, dreams of self-actualization, ambitions to win respect and build esteem, hobbies, side-projects, desires to support friends and family, but the truth is that is we don't first take care of the basic needs; phisiological, safety and security, financial stability, then the higher goals will suffer, or become unobtainable. 

It is important, in a personal task-management system, that we can quickly record any task for any level, to track things we would like to do, but if that big list of tasks presents an opportunity to be distracted, to do things that are easier and more fun, than the more important tasks, then the system becomes it's own problem.

The intended outcome of this extension is a tool that will help average users take care of that which is most *important*, without being distracted by neat ideas and lofty ambitions. If you have tasks for things you need to do to stay alive (need:1) or your personal safety and security(need:2), then you shouldn't even be looking at any other tasks! Likewise, tasks  around friends, family and home-life (need:3) should all be done before being distracted by tasks for things that might be totally cool and/or make you rich and famous some day (need:4). You will only ever achieve need:5 tasks (self actualization) with need:1-4 tasks well behind you, and by then, you might know your need:6 (Higher Goals) tasks.. maybe.



