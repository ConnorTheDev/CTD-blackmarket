Config = {}

Config.UsingTarget = true

--Config.Testing = vector3(249.11, -790.34, 29.43)

Config.Products = {
    ["SOA"] = {
        [1] = {
            name = "weapon_pistol",
            price = 500,
            amount = 500,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "weapon_smg",
            price = 2500,
            amount = 500,
            info = {},
            type = "item",
            slot = 2,
        },
    },
    ["Baller"] = {
        [1] = {
            name = "weapon_smg",
            price = 2000,
            amount = 50,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "weapon_pistol",
            price = 500,
            amount = 500,
            info = {},
            type = "item",
            slot = 1,
        },
    }
}

Config.blackmarkets = {
    ["SoaMarket"] = {
        ["label"] = "Soa Market",
        ["coords"] = {
            [1] = vector4(963.69, -118.76, 73.35, 217.44) --coords for the ped
        },
        ["products"] = Config.Products["SOA"],
        gang = "lostmc" -- change this to the gang you wanna use. has to be in the gangs.lua
    },
    ["BallarMarket"] = {
        ["label"] = "Baller Market",
        ["coords"] = {
            [1] = vector4(211.02, -779.5, 30.03, 253.19)
        },
        ["products"] = Config.Products["Baller"],
        gang = "ballars"
    },
}