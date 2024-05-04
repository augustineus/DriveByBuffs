# DriveByBuffs
An RP Addon for World of Warcraft Classic to thank players for "drive by" buffs.

When you're running through the Barrens and get a MoTW, you'll automatically emote positively at the buffer.

Currently, the emote list consists of the following pieces:
local emotes = {"is amazed by ", "blushes at ", "bows before ", "cheers for ", "claps for ", "is happy with ", "hugs ", "blows a kiss at ", "salutes ", "thanks ",
                "cuddles up to ", "highly praises ", "gives many commendations to ", "flirts with "}

These pieces will come out as "{playerName} bows before {bufferName} for their {approvedBuffName}".

The current list of approved buffs are:
local validBuffs = {"Arcane Intellect", "Power Word: Fortitude", "Mark of the Wild", "Thorns", "Blessing of Wisdom", "Blessing of Might", "Blessing of Kings",
"Blessing of Sanctuary", "Blessing of Light", "Divine Spirit", "Shadow Protection", "Detect Greater Invisibility", "Detect Invisibility", "Detect Lesser Invisibility",
"Unending Breath"}
