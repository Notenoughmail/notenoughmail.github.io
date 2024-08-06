---
layout: page
title: Calendar Bindings
permalink: /kubejs_tfc/1.20.1/bindings/calendar/
parent: Bindings
grand_parent: 1.20.1
---

# Calendar Bindings

TFC uses a calendar system to keep track of time in its recipes and fuel systems, this provides access to some of the information provided by the calendars

These are available under the `TFC.calendar` field

## Method Signatures

```ts
TFC.calendar.getCalendar()
TFC.calendar.getCalendar(isClientSide: boolean)
TFC.calendar.getCalendar(level: LevelReader)
TFC.calendar.getCalendar(entity: Entity)
TFC.calendar.getCalendar(be: BlockEntity)
TFC.calendar.getCalendarTicksInMonth(daysInMonth: number)
TFC.calendar.getCalendarTicksInYear(daysInMonth: number)
TFC.calendar.getTotalMinutes(time: number)
TFC.calendar.getTotalHours(time: number)
TFC.calendar.getTotalDays(time: number)
TFC.calendar.getTotalMonths(time: number, daysInMonth: number)
TFC.calendar.getTotalYears(time: number, daysInMonth: number)
TFC.calendar.getMinuteOfHour(time: number)
TFC.calendar.getHourOfDay(time: number)
TFC.calendar.getDayOfMonth(time: number, daysInMonth: number)
TFC.calendar.getMonthOfYear(time: number, daysInMonth: number)
TFC.calendar.getFractionOfMonth(time: number, daysInMonth: number)
TFC.calendar.getFractionOfYear(time: number, daysInMonth: number)
TFC.calendar.getTimeAndDate(time: number, daysInMonth: number)
TFC.calendar.getTimeAndDate(hour: number, minute: number, month: Month, day: number, years: number)
TFC.calendar.getTimeDelta(ticks: number, daysInMonth: number)
```

- `.getCalendar()`: Returns either the server or client [ICalendar](#icalendar) object, a best guess attempt is made to determine which is returned
- `.getCalendar(isClientSide: boolean)`: Returns either the server, if false, or client, if true, [ICalendar](#icalendar)
- `.getCalendar(level: LevelReader)`: Returns the level's [ICalendar](#icalendar)
- `.getCalendar(entity: Entity)`: Returns the entity's level's [ICalendar](#icalendar)
- `.TFC.calendar.getCalendar(be: BlockEntity)`: Returns the block entity's level's [ICalendar](#icalendar), if present, else the the best guess on the appropriate calendar
- `.getCalendarTicksInMonth(daysInMonth: number)`: Returns the number of calendar ticks in a month for the provided number of days in a month
- `.getCalendarTicksInYear(daysInMonth: number)`: Returns the number of calendar ticks in a year for the provided number of days in a month
- `.getTotalMinutes(time: number)`: Returns the number of minutes in the provided number of ticks
- `.getTotalHours(time: number)`: Returns the number of hours in the provided number of ticks
- `.getTotalDays(time: number)`: Returns the number of days in the provided number of ticks
- `.getTotalMonths(time: number, daysInMonth: number)`: Returns the number of months in the provided number of ticks and days in a month
- `.getTotalYears(time: number, daysInMonth: number)`: Returns the number of years in the provided number of ticks and days in a month
- `.getMinuteOfHour(time: number)`: Returns the minute of the hour for the given tick
- `.getHourOfDay(time: number)`: Returns the hour of the day for the given tick
- `.getDayOfMonth(time: number, daysInMonth: number)`: Returns the day of the month for the given tick and number of days in a month
- `.getMonthOfYear(time: number, daysInMonth: number)`: Returns the month of the year for the given tick and number of days in a month
- `.getFractionOfMonth(time: number, daysInMonth: number)`: Returns the fraction, in the range [0, 1], of the month for the given tick and number of days in a month
- `.getFractionOfYear(time: number, daysInMonth: number)`: Returns the fraction, in the range [0, 1], of the year for the given tick and number of days in a month
- `.getTimeAndDate(time: number, daysInMonth: number)`: Returns a `MutableComponent` describing the date and time from the given number of ticks and days in a month
- `.getTimeAndDate(hour: number, minute: number, month: Month, day: number, years: number)`: Returns a `MutableComponent` describing the date and time from the given hour, minute, month, day, and year
- `.getTimeDelta(ticks: number, daysInMonth: number)`: Returns a `MutableComponent` describing the time delta of the given number of ticks and days in a month

# ICalendar

A `ICalendar` is an object which keeps track of time, TFC has one for the client and one for the server which have different purposes, but they both have access to a common set of values

## Method Signatures

```ts
declare class IClander {
    getTicks(): number
    getCalendarTicks(): number
    getCalendarDaysInMonth(): number
    ticksToCalendarTicks(tick: number): number
    getTotalHours(): number
    getTotalCalendarHours(): number
    getTotalDays(): number
    getTotalCalendarDays(): number
    getTotalMonths(): number
    getTotalCalendarMonths(): number
    getTotalYears(): number
    getTotalCalendarYears(): number
    getCalendarDayTime(): number
    getCalendarDayOfMonth(): number
    getCalendarFractionOfMonth(): number
    getCalendarFractionOfYear(): number
    getCalendarDayOfYear(): MutableComponent
    getCalendarMonthOfYear(): Month
    getCalendarTicksInMonth(): number
    getCalendarTicksInYear(): number
    getCalendarTimeAndDate(): MutableComponent
    getTimeDelta(ticks: number): MutableComponent
}
```

- `.getTicks()`: Returns the absolute number of time since the world was created. Safe to store timestamps with
- `.getCalendarTicks()`: Returns the number of ticks since Jan 1, 1000
- `.getCalendarDaysInMonth()`: Returns the number of days in a month
- `.ticksToCalendarTicks(tick: number)`: Returns the corresponding calendar tick of the given tick
- `.getTotalHours()`: Returns the total amount of hours passed
- `.getTotalCalendarHours()`: Returns the total amount of hours passed since Jan 1, 1000
- `.getTotalDays()`: Returns the total number of days passed
- `.getTotalCalendarDays()`: Returns the total number of days passed since Jan 1, 1000
- `.getTotalMonths()`: Returns the total number of months passed
- `.getTotalCalendarMonths()`: Returns the total number of months passed since Jan 1, 1000
- `.getTotalYears()`: Returns the total number of years passed
- `.getTotalCalendarYears()`: Returns the total number of years passed since jan 1, 1000
- `.getCalendarDayTime()`: Returns the time of day, in the range [0, 24000), should match `Level#getDayTime()`
- `.getCalendarDayOfMonth()`: Returns the day of the month from the calendar time
- `.getCalendarFractionOfMonth()`: Returns the progress, in the range [0, 1] through the month from the calendar time
- `.getCalendarFractionOfYear()`: Returns the progress through the year, in the range [0, 1] from the calendar time, where Jan 1 = 0
- `.getCalendarDayOfYear()`: Returns a `MutableComponent` describing the current day of the week from the calendar time
- `.getCalendarMonthOfYear()`: Returns the month of the year from the calendar time
- `.getCalendarTicksInMonth()`: Returns the total number of ticks in a month
- `.getCalendarTicksInYear()`: Returns the total number of ticks in a year
- `.getCalendarTimeAndDate()`: Returns a `MutableComponent` describing the current timestamp, i.e. `00:00 January 1, 1000`
- `.getTimeDelta(ticks: number)`: Returns a `MutableComponent` describing the time delta of the provided number of ticks
