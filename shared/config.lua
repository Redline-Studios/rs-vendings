Config = {}

-- Debug Config --
Config.Debug = true

-- Minigame Config --
Config.Minigame = {
    Circles = 4,
    Time = 20
}
Config.EatMoney = 8 -- Chance that the machine eats your money if you fail the minigame (Chance is out of 10)

Config.Machines = {
    ['water'] = {
        Models = {
            `prop_vend_water_01`,
            `prop_watercooler`,
            `prop_watercooler_Dark`
        },
        Target = {
            Label = 'Water Machine',
            Icon = 'fas fa-droplet',
        },
        Vending = {
            [1] = {
                item = "water_bottle",
                price = 2,
            },
        }
    },
    ['soda'] = {
        Models = {
            `prop_vend_fridge01`,
            `prop_vend_soda_01`,
            `prop_vend_soda_02`
        },
        Target = {
            Label = 'Soda Machine',
            Icon = 'fas fa-droplet',
        },
        Vending = {
            [1] = {
                item = "kurkakola",
                price = 2,
            },
        }
    },
    ['coffee'] = {
        Models = {
            `prop_vend_coffe_01`
        },
        Target = {
            Label = 'Coffee Machine',
            Icon = 'fas fa-mug-hot',
        },
        Vending = {
            [1] = {
                item = "coffee",
                price = 2,
            },
        }
    },
    ['snacks'] = {
        Models = {
            `prop_vend_snak_01`,
            `prop_vend_snak_01_tu`,
        },
        Target = {
            Label = 'Snack Machine',
            Icon = 'fas fa-candy-cane',
        },
        Vending = {
            [1] = {
                item = "snikkel_candy",
                price = 2,
            },
        }
    },
    ['smokes'] = {
        Models = {
            `prop_vend_fags_01`,
        },
        Target = {
            Label = 'Smokes Vending',
            Icon = 'fas fa-smoking',
        },
        Vending = {
            [1] = {
                item = "cigarette",
                price = 2,
            },
        }
    },
}