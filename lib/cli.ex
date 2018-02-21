defmodule CLI do
  def options do
    [
      name: "unicli",
      description: "get a hand on Ubiquity's UniFi controller",
      version: "0.0.1",
      author: "Antoine POPINEAU <antoine.popineau@appscho.com>",
      allow_unknown_flags: false,
      allow_double_dash: true,
      subcommands: [
        devices: [
          name: "devices",
          description: "control UniFi devices",
          subcommands: [
            list: [
              name: "list",
              description: "list all adopted UniFi devices"
            ],
            locate: [
              name: "locate",
              description: "enable or disable blinking of device LEDs",
              args: [
                id: [
                  value_name: "DEVICE_ID",
                  help: "ID of the device to locate",
                  required: true,
                  parser: :string
                ],
                state: [
                  value_name: "STATE",
                  help: "ID of the device to locate",
                  required: true,
                  parser: fn
                    "on" -> {:ok, true}
                    "off" -> {:ok, false}
                    _ -> {:error, "only 'on' and 'off' are accepted"}
                  end
                ]
              ]
            ],
            ports: [
              name: "ports",
              description: "control device ports",
              subcommands: [
                list: [
                  name: "list",
                  description: "list all ports on a device",
                  args: [
                    id: [
                      value_name: "DEVICE_ID",
                      help: "ID of the device to inspect",
                      required: true,
                      parser: :string
                    ]
                  ]
                ],
                disable: [
                  name: "disable",
                  description: "disable a port",
                  args: [
                    device_id: [
                      value_name: "DEVICE_ID",
                      help: "ID of the device to disable a port from",
                      required: true,
                      parser: :string
                    ],
                    id: [
                      value_name: "PORT_ID",
                      help: "ID of the port to disable",
                      required: true,
                      parser: :string
                    ]
                  ]
                ],
                enable: [
                  name: "enable",
                  description: "enable a port",
                  args: [
                    device_id: [
                      value_name: "DEVICE_ID",
                      help: "ID of the device to enable a port from",
                      required: true,
                      parser: :string
                    ],
                    id: [
                      value_name: "PORT_ID",
                      help: "ID of the port to enable",
                      required: true,
                      parser: :string
                    ]
                  ]
                ]
              ]
            ]
          ]
        ],
        networks: [
          name: "networks",
          description: "control UniFi networks",
          subcommands: [
            wlan: [
              name: "wlan",
              description: "control UniFi wireless networks",
              subcommands: [
                list: [
                  name: "list",
                  description: "list all configured wireless networks"
                ],
                enable: [
                  name: "enable",
                  description: "enable a specific wireless network",
                  args: [
                    id: [
                      value_name: "NETWORK_ID",
                      help: "ID of the wireless network to enable",
                      required: true,
                      parser: :string
                    ]
                  ]
                ],
                disable: [
                  name: "disable",
                  description: "disable a specific wireless network",
                  args: [
                    id: [
                      value_name: "NETWORK_ID",
                      help: "ID of the wireless network to disable",
                      required: true,
                      parser: :string
                    ]
                  ]
                ]
              ]
            ],
            list: [
              name: "list",
              description: "list all UniFi virtual networks"
            ]
          ]
        ],
        clients: [
          name: "clients",
          description: "control connected clients",
          subcommands: [
            list: [
              name: "list",
              description: "list all connected users"
            ],
            block: [
              name: "block",
              description: "block a client from the network",
              args: [
                mac: [
                  value_name: "CLIENT_MAC",
                  help: "MAC address of the client to block",
                  required: true,
                  parser: :string
                ]
              ]
            ],
            unblock: [
              name: "unblock",
              description: "unblock a client from the network",
              args: [
                mac: [
                  value_name: "CLIENT_MAC",
                  help: "MAC address of the client to unblock",
                  required: true,
                  parser: :string
                ]
              ]
            ]
          ]
        ],
        vouchers: [
          name: "vouchers",
          description: "manage HotSpot vouchers",
          subcommands: [
            list: [
              name: "list",
              description: "list all active vouchers"
            ],
            create: [
              name: "create",
              description: "create a voucher",
              options: [
                number: [
                  short: "-n",
                  help: "how many vouchers to create",
                  default: 1,
                  parser: :integer
                ],
                validity: [
                  short: "-e",
                  help: "validity duration (as ISO8601 durations, e.g. PT24H, etc.)",
                  default: 1440,
                  parser: fn d ->
                    case Timex.Duration.parse(d) do
                      {:error, _} -> {:error, "invalid validity duration"}
                      {:ok, seconds} -> {:ok, round(Timex.Duration.to_minutes(seconds))}
                    end
                  end
                ],
                usage: [
                  short: "-t",
                  help: "number of times this voucher can be used (0 for unlimited)",
                  default: 1,
                  parser: :integer
                ],
                comment: [
                  short: "-c",
                  help: "comment",
                  default: "Created from UniCLI"
                ],
                quota: [
                  short: "-q",
                  help: "usage quota in MB",
                  default: 0,
                  parser: :integer
                ],
                quota_download: [
                  short: "-d",
                  help: "download bandwidth limit in Kbps",
                  default: 0,
                  parser: :integer
                ],
                quota_upload: [
                  short: "-u",
                  help: "upload bandwidth limit in Kbps",
                  default: 0,
                  parser: :integer
                ]
              ]
            ],
            revoke: [
              name: "revoke",
              description: "revoke a voucher",
              args: [
                id: [
                  value_name: "VOUCHER_ID",
                  help: "ID of the voucher to revoke",
                  required: true,
                  parser: :string
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  end
end
