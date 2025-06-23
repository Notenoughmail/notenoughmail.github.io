---
layout: page
title: 1.20.1
permalink: /configjs/1.20.1/
has_children: false
parent: ConfigJS
---

# 1.20.1

- [Bindings](#bindings)
- [Events](#events)

## Bindings

ConfigJS adds a single binding to scripts, the `ConfigJS` object which has only one method:

```js
declare class ConfigJS {
    getOtherValueFromEnumConfig(configValue: ForgeConfigSpec$EnumValue<T>, name: String): T
}
```

This returns the enum constant, if it exists, from the enum config's enum class

### Example

```js
ConfigJS.getOtherValueFromEnumConfig(global.selector, 'supreme')
```

## Events

ConfigJS adds three startup events, `ConfigsEvent.common`, `ConfigsEvent.server`, and `ConfigsEvent.client` they define a config of the associated type and have the same methods as each other

```js
declare class ConfigEventJS {
    setName(name: String): ConfigEventJS
    pop(i?: number): ConfigEventJS
    push(path: String): ConfigEventJS
    swap(path: String): ConfigEventJS
    comment(comments...: String[]): ConfigEventJS
    intValue(name: String, defaultValue: number, min: number, max: number): ForgeConfigSpec$IntValue
    longValue(name: String, defaultValue: number, min: number, max: number): ForgeConfigSpec$LongValue
    doubleValue(name: String, defaultValue: number, min: number, max: number): ForgeConfigSpec$DoubleValue
    booleanValue(name: String, defaultValue: boolean): ForgeConfigSpec$BooleanValue
    enumValue(name: String, defaultValue: String, enumValues: String[]): ForgeConfigSpec$EnumValue<? extends Enum<?>>
    enumValue(name: String, defaultValue: T extends Enum<T>): ForgeConfigSpec$EnumValue<T>
    stringValue(name: String, defaultValue: String): ForgeConfigSpec$ConfigValue<String>
    stringValueWithPredicate(name: String, defaultValue: String, validator: Predicate<String>): ForgeConfigSpec$ConfigValue<String>
    stringValue(name: String, defaultValue: String, allowedValues: String[]): ForgeConfigSpec$ConfigValue<String>
    stringListValue(name: String, defaultValues: String[], validator: Predicate<String>): ForgeConfigSpec$ConfigValue<List<? extends String>>
}
```

- `.setName(name: String)`{: .language-javascript }: Sets the name of the config file, defaults to `configjs-<configType>`
- `.pop(i?: number)`{: .language-javascript }: Moves the active section to be edited left by the specified number of tabs, defaults to `1`
- `.push(path: String)`{: .language-javascript }: Adds a section to the config with the given name and moves the active section right by one
- `.swap(path: String)`{: .language-javascript }: Pops the active section by 1 and pushes the given path as the active section
- `.comment(comments...: String[])`{: .language-javascript }: Adds the given strings as comments to the file, each new string is a new line

The following options actually define a config value, and return an instance of a `ForgeConfigSpec$ConfigValue<?>`, it is strongly recommended to use the `global` binding to use the values throughout your scripts, a demonstration can be seen in the example

- `.intValue(name: String, defaultValue: number, min: number, max: number)`{: .language-javascript }: Defines a new integer config option
    - Name: The name of the config option
    - DefaultValue: The default values of the option, must be between the minimum and maximum values specified
    - Min: The minimum value the config option may be, inclusive
    - Max: The maximum values the config option may be, inclusive
- `.longValue(name: String, defaultValue: number, min: number, max: number)`{: .language-javascript }: Defines a new long config option
    - Name: The name of the config option
    - DefaultValue: The default values of the option, must be between the minimum and maximum values specified
    - Min: The minimum value the config option may be, inclusive
    - Max: The maximum values the config option may be, inclusive
- `.doubleValue(name: String, defaultValue: number, min: number, max: number)`{: .language-javascript }: Defines a new double config option
    - Name: The name of the config option
    - DefaultValue: The default values of the option, must be between the minimum and maximum values specified
    - Min: The minimum value the config option may be, inclusive
    - Max: The maximum values the config option may be, inclusive
- `.booleanValue(name: String, defaultValue: boolean)`{: .language-javascript }: Defines a new boolean config option
    - Name: The name of the config option
    - DefaultValue: The default value of the option
- `.enumValue(name: String, defaultValue: String, enumValues: String[])`{: .language-javascript }: Defines a new enum config option
    - Name: The name of the config option
    - DefaultValue: The default enum value for the config, should be included in `enumValues`
    - EnumValues: The list of allowed values for the config option
- `.enumValue(name: String, defaultValue: T extends Enum<T>)`{: .language-javascript }: Defines a new enum config option from the class of the given enum value
    - Name: The name of the config option
    - DefaultValue: An enum value
- `.stringValue(name: String, defaultValue: String)`{: .language-javascript }: Defines a new string config option, accepts any non-empty string
    - Name: The name of the config option
    - DefaultValue: The default value for the config
- `.stringValueWithPredicate(name: String, defaultValue: String, validator: Predicate<String>)`{: .language-javascript }: Defines a new string config option
    - Name: The name of the config option
    - DefaultValue: The default value for the config
    - Validator: A callback that gives a string and expects a boolean to be returned, determines what config values are valid, should permit the default value
- `.stringValue(name: String, defaultValue: String, allowedValues: String[])`{: .language-javascript }: Defines a new string config option
    - Name: The name of the config option
    - DefaultValue: The default value for the config option
    - AllowedValues: The values that are valid for this config option. should include the default value
- `.stringListValue(name: String, defaultValues: String[], validator: Predicate<String>)`{: .language-javascript }: Defines a new string list config option
    - Name: The name of the config option
    - DefaultValues: The default values of the config option
    - Validator: The validator of the elements of the config's elements, should permit the default values

### Example

```js
ConfigsEvent.common(event => {
    event.setName('My Very Cool Config File')
    event.push('debug')
    event.comment('Determines how many particles should be spawned around the player in debug mode')
    global.debugParticleCount = event.intValue('numberOfParticles', 0, 0, 20)
    event.comment('Determines if debug mode is enabled')
    global.debugEnabled = event.booleanValue('enabled', false)
    event.pop().comment('be wild!')
    global.selector = event.enumValue('selectorType', 'basic', ['basic', 'advanced', 'supreme'])
})
```

Would create a config file roughly like

```toml
# In configs/My Very Cool Config File.toml

[debug]
    #
    # Determines how many particles should be spawned around the player in debug mode
    #Range: 0 ~ 20
    numberOfParticles = 0
    #
    # Determines if debug mode is enabled
    enabled = false

#
# be wild!
#Allowed Values: basic, advanced, supreme
selectorType = "basic"

```
