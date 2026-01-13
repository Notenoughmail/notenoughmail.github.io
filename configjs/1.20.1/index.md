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

```js-20
declare class ConfigJS {
    getOtherValueFromEnumConfig(configValue: ForgeConfigSpec$EnumValue<T>, name: String): T
}
```

This returns the enum constant, if it exists, from the enum config's enum class

### Example

```js-20
ConfigJS.getOtherValueFromEnumConfig(global.selector, 'supreme')
```

## Events

ConfigJS adds three startup events, `ConfigsEvent.common`, `ConfigsEvent.server`, and `ConfigsEvent.client` they define a config of the associated type and have the same methods as each other

```js-20
event.setName(name: String): ConfigEventJS
event.pop(i?: number): ConfigEventJS
event.push(path: String): ConfigEventJS
event.swap(path: String): ConfigEventJS
event.comment(comments...: String[]): ConfigEventJS
event.intValue(name: String, defaultValue: number, min: number, max: number): ForgeConfigSpec$IntValue
event.longValue(name: String, defaultValue: number, min: number, max: number): ForgeConfigSpec$LongValue
event.doubleValue(name: String, defaultValue: number, min: number, max: number): ForgeConfigSpec$DoubleValue
event.booleanValue(name: String, defaultValue: boolean): ForgeConfigSpec$BooleanValue
event.enumValue(name: String, defaultValue: String, enumValues: String[]): ForgeConfigSpec$EnumValue<? extends Enum<?>>
event.enumValue(name: String, defaultValue: T extends Enum<T>): ForgeConfigSpec$EnumValue<T>
event.stringValue(name: String, defaultValue: String): ForgeConfigSpec$ConfigValue<String>
event.stringValueWithPredicate(name: String, defaultValue: String, validator: Predicate<String>): ForgeConfigSpec$ConfigValue<String>
event.stringValue(name: String, defaultValue: String, allowedValues: String[]): ForgeConfigSpec$ConfigValue<String>
event.stringListValue(name: String, defaultValues: String[], validator: Predicate<String>): ForgeConfigSpec$ConfigValue<List<? extends String>>
```

- `.setName(name: String)`{: .language-kube-20 }: Sets the name of the config file, defaults to `configjs-<configType>`
- `.pop(i?: number)`{: .language-kube-20 }: Moves the active section to be edited left by the specified number of tabs, defaults to `1`
- `.push(path: String)`{: .language-kube-20 }: Adds a section to the config with the given name and moves the active section right by one
- `.swap(path: String)`{: .language-kube-20 }: Pops the active section by 1 and pushes the given path as the active section
- `.comment(comments...: String[])`{: .language-kube-20 }: Adds the given strings as comments to the file, each new string is a new line

The following options actually define a config value, and return an instance of a `ForgeConfigSpec$ConfigValue<?>`, it is strongly recommended to use the `global` binding to use the values throughout your scripts, a demonstration can be seen in the example

- `.intValue(name: String, defaultValue: number, min: number, max: number)`{: .language-kube-20 }: Defines a new integer config option
    - `name: String`{: .language-kube-20 }: The name of the config option
    - `defaultValue: number`{: .language-kube-20 }: The default values of the option, must be between the minimum and maximum values specified
    - `min: number`{: .language-kube-20 }: The minimum value the config option may be, inclusive
    - `max: number`{: .language-kube-20 }: The maximum values the config option may be, inclusive
- `.longValue(name: String, defaultValue: number, min: number, max: number)`{: .language-kube-20 }: Defines a new long config option
    - `name: String`{: .language-kube-20 }: The name of the config option
    - `defaultValue: number`: The default values of the option, must be between the minimum and maximum values specified
    - `min: number`{: .language-kube-20 }: The minimum value the config option may be, inclusive
    - `max: number`{: .language-kube-20 }: The maximum values the config option may be, inclusive
- `.doubleValue(name: String, defaultValue: number, min: number, max: number)`{: .language-kube-20 }: Defines a new double config option
    - `name: String`{: .language-kube-20 }: The name of the config option
    - `defaultValue: number`{: .language-kube-20 }: The default values of the option, must be between the minimum and maximum values specified
    - `min: number`{: .language-kube-20 }: The minimum value the config option may be, inclusive
    - `max: number`{: .language-kube-20 }: The maximum values the config option may be, inclusive
- `.booleanValue(name: String, defaultValue: boolean)`{: .language-kube-20 }: Defines a new boolean config option
    - `name: String`{: .language-kube-20 }: The name of the config option
    - `defaultValue: boolean`{: .language-kube-20 }: The default value of the option
- `.enumValue(name: String, defaultValue: String, enumValues: String[])`{: .language-kube-20 }: Defines a new enum config option
    - `name: String`{: .language-kube-20 }: The name of the config option
    - `defaultValue: String`{: .language-kube-20 }: The default enum value for the config, should be included in `enumValues`
    - `enumValues: String[]`{: .language-kube-20 }: The list of allowed values for the config option
- `.enumValue(name: String, defaultValue: T extends Enum<T>)`{: .language-kube-20 }: Defines a new enum config option from the class of the given enum value
    - `name: String`{: .language-kube-20 }: The name of the config option
    - `defaultValue: T`: An enum value
- `.stringValue(name: String, defaultValue: String)`{: .language-kube-20 }: Defines a new string config option, accepts any non-empty string
    - `name: String`{: .language-kube-20 }: The name of the config option
    - `defaultValue: String`: The default value for the config
- `.stringValueWithPredicate(name: String, defaultValue: String, validator: Predicate<String>)`{: .language-kube-20 }: Defines a new string config option
    - `name: String`: The name of the config option
    - `defaultValue: String`: The default value for the config
    - `validator: Predicate<String>`{: .language-kube-20 }: A callback that gives a string and expects a boolean to be returned, determines what config values are valid, should permit the default value
- `.stringValue(name: String, defaultValue: String, allowedValues: String[])`{: .language-kube-20 }: Defines a new string config option
    - `name: String`{: .language-kube-20 }: The name of the config option
    - `defaultValue: String`{: .language-kube-20 }: The default value for the config option
    - `allowedValues: String[]`{: .language-kube-20 }: The values that are valid for this config option. should include the default value
- `.stringListValue(name: String, defaultValues: String[], validator: Predicate<String>)`{: .language-kube-20 }: Defines a new string list config option
    - `name: String`{: .language-kube-20 }: The name of the config option
    - `defaultValues: String[]`{: .language-kube-20 }: The default values of the config option
    - `validator: Predicate<String>`{: .language-kube-20 }: The validator of the elements of the config's elements, should permit the default values

### Example

```js-20
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
