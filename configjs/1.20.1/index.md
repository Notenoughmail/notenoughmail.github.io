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

```ts
declare class ConfigJS {
    getOtherValueFromEnumConfig(configValue: ForgeConfigSpec$EnumValue<T>, name: string): T
}
```

This returns the enum constant, if it exists, from the enum config's enum class

### Example

```js
ConfigJS.getOtherValueFromEnumConfig(global.selector, 'supreme')
```

## Events

ConfigJS adds three startup events, `ConfigsEvent.common`, `ConfigsEvent.server`, and `ConfigsEvent.client` they define a config of the associated type and have the same methods as each other

```ts
declare class ConfigEventJS {
    setName(name: string): ConfigEventJS
    pop(i?: number): ConfigEventJS
    push(path: string): ConfigEventJS
    swap(path: string): ConfigEventJS
    comment(comments...: string[]): ConfigEventJS
    intValue(name: string, defaultValue: number, min: number, max: number): ForgeConfigSpec$IntValue
    longValue(name: string, defaultValue: number, min: number, max: number): ForgeConfigSpec$LongValue
    doubleValue(name: string, defaultValue: number, min: number, max: number): ForgeConfigSpec$DoubleValue
    booleanValue(name: string, defaultValue: boolean): ForgeConfigSpec$BooleanValue
    enumValue(name: string, defaultValue: string, enumValues: string[]): ForgeConfigSpec$EnumValue<? extends Enum<?>>
    enumValue(name: string, defaultValue: T extends Enum<T>): ForgeConfigSpec$EnumValue<T>
    stringValue(name: string, defaultValue: string): ForgeConfigSpec$ConfigValue<string>
    stringValueWithPredicate(name: string, defaultValue: string, validator: Predicate<string>): ForgeConfigSpec$ConfigValue<string>
    stringValue(name: string, defaultValue: string, allowedValues: string[]): ForgeConfigSpec$ConfigValue<string>
    stringListValue(name: string, defaultValues: string[], validator: Predicate<string>): ForgeConfigSpec$ConfigValue<List<? extends string>>
}
```

- `setName(name: string)`: Sets the name of the config file, defaults to `configjs-<configType>`
- `pop(i?: number)`: Moves the active section to be edited left by the specified number of tabs, defaults to `1`
- `push(path: string)`: Adds a section to the config with the given name and moves the active section right by one
- `swap(path: string)`: Pops the active section by 1 and pushes the given path as the active section
- `comment(comments...: string[])`: Adds the given strings as comments to the file, each new string is a new line

The following options actually define a config value, and return an instance of a `ForgeConfigSpec$ConfigValue<?>`, it is strongly recommended to use the `global` binding to use the values throughout your scripts, a demonstration can be seen in the example

- `intValue(name: string, defaultValue: number, min: number, max: number)`: Defines a new integer config option
    - Name: The name of the config option
    - DefaultValue: The default values of the option, must be between the minimum and maximum values specified
    - Min: The minimum value the config option may be, inclusive
    - Max: The maximum values the config option may be, inclusive
- `longValue(name: string, defaultValue: number, min: number, max: number)`: Defines a new long config option
    - Name: The name of the config option
    - DefaultValue: The default values of the option, must be between the minimum and maximum values specified
    - Min: The minimum value the config option may be, inclusive
    - Max: The maximum values the config option may be, inclusive
- `doubleValue(name: string, defaultValue: number, min: number, max: number)`: Defines a new double config option
    - Name: The name of the config option
    - DefaultValue: The default values of the option, must be between the minimum and maximum values specified
    - Min: The minimum value the config option may be, inclusive
    - Max: The maximum values the config option may be, inclusive
- `booleanValue(name: string, defaultValue: boolean)`: Defines a new boolean config option
    - Name: The name of the config option
    - DefaultValue: The default value of the option
- `enumValue(name: string, defaultValue: string, enumValues: string[])`: Defines a new enum config option
    - Name: The name of the config option
    - DefaultValue: The default enum value for the config, should be included in `enumValues`
    - EnumValues: The list of allowed values for the config option
- `enumValue(name: string, defaultValue: T extends Enum<T>)`: Defines a new enum config option from the class of the given enum value
    - Name: The name of the config option
    - DefaultValue: An enum value
- `stringValue(name: string, defaultValue: string)`: Defines a new string config option, accepts any non-empty string
    - Name: The name of the config option
    - DefaultValue: The default value for the config
- `stringValueWithPredicate(name: string, defaultValue: string, validator: Predicate<string>)`: Defines a new string config option
    - Name: The name of the config option
    - DefaultValue: The default value for the config
    - Validator: A callback that gives a string and expects a boolean to be returned, determines what config values are valid, should permit the default value
- `stringValue(name: string, defaultValue: string, allowedValues: string[])`: Defines a new string config option
    - Name: The name of the config option
    - DefaultValue: The default value for the config option
    - AllowedValues: The values that are valid for this config option. should include the default value
- `stringListValue(name: string, defaultValues: string[], validator: Predicate<string>)`: Defines a new string list config option
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
