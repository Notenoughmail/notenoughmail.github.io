---
layout: page
title: 1.20
permalink: /configjs/1.20.1/
has_children: true
---

# 1.20

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
ConfigJS.getOtherValueFromEnumConfig(global.commonConfig.customEnum, 'Really cool to be here')
```

## Events

ConfigJS adds three startup events, `ConfigsEvent.common`, `ConfigsEvent.server`, and `ConfigsEvent.client` they define a config of the associated type and the same methods

```ts
declare class ConfigEventJS {
    setName(name: string): void
    pop(): void
    pop(i : number): void
    push(path: string): void
    comment(comments...: string[])
    intValue(name: string, defaultValue: number, min: number, max: number): ForgeConfigSpec$IntValue
    longValue(name: string, defaultValue: number, min: number, max: number): ForgeConfigSpec$LongValue
    doubleValue(name: string, defaultValue: number, min: number, max: number): ForgeConfigSpec$DoubleValue
    booleanValue(name: string, defaultValue: boolean): ForgeConfigSpec$BooleanValue
    enumValue(name: string, defaultValue: string, enumValues: List<string>): ForgeConfigSpec$EnumValue<? extends Enum>
    enumValue(name: string, defaultValue: T extends Enum): ForgeConfigSpec$EnumValue<T>
}
```
