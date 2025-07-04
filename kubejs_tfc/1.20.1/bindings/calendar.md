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

```js
TFC.calendar.TICKS_IN_HOUR
TFC.calendar.HOURS_IN_DAY
TFC.calendar.TICKS_IN_DAY
TFC.calendar.MONTHS_IN_YEAR
TFC.calendar.TICKS_IN_MINUTE
TFC.calendar.getCalendar(): ICalendar
TFC.calendar.getCalendar(isClientSide: boolean): ICalendar
TFC.calendar.getCalendar(level: LevelReader): ICalendar
TFC.calendar.getCalendar(entity: Entity): ICalendar
TFC.calendar.getCalendar(be: BlockEntity): ICalendar
TFC.calendar.getCalendarTicksInMonth(daysInMonth: number): number
TFC.calendar.getCalendarTicksInYear(daysInMonth: number): number
TFC.calendar.getTotalMinutes(time: number): number
TFC.calendar.getTotalHours(time: number): number
TFC.calendar.getTotalDays(time: number): number
TFC.calendar.getTotalMonths(time: number, daysInMonth: number): number
TFC.calendar.getTotalYears(time: number, daysInMonth: number): number
TFC.calendar.getMinuteOfHour(time: number): number
TFC.calendar.getHourOfDay(time: number): number
TFC.calendar.getDayOfMonth(time: number, daysInMonth: number): number
TFC.calendar.getMonthOfYear(time: number, daysInMonth: number): Month
TFC.calendar.getFractionOfMonth(time: number, daysInMonth: number): number
TFC.calendar.getFractionOfYear(time: number, daysInMonth: number): number
TFC.calendar.getTimeAndDate(time: number, daysInMonth: number): MutableComponent
TFC.calendar.getTimeAndDate(hour: number, minute: number, month: Month, day: number, years: number): MutableComponent
TFC.calendar.getTimeDelta(ticks: number, daysInMonth: number): MutableComponent
```

- `.getCalendar()`{: .language-javascript .m-link #calendar-0 }: Returns either the server or client [ICalendar](#icalendar) object, a best guess attempt is made to determine which is returned
- `.getCalendar(isClientSide: boolean)`{: .language-javascript .m-link #calendar-1 }: Returns either the server, if false, or client, if true, [ICalendar](#icalendar)
- `.getCalendar(level: LevelReader)`{: .language-javascript .m-link #calendar-2 }: Returns the level's [ICalendar](#icalendar)
- `.getCalendar(entity: Entity)`{: .language-javascript .m-link #calendar-3 }: Returns the entity's level's [ICalendar](#icalendar)
- `.getCalendar(be: BlockEntity)`{: .language-javascript .m-link #calendar-4 }: Returns the block entity's level's [ICalendar](#icalendar), if present, else the the best guess on the appropriate calendar
- `.getCalendarTicksInMonth(daysInMonth: number)`{: .language-javascript .m-link #ticks-in-month }: Returns the number of calendar ticks in a month for the provided number of days in a month
- `.getCalendarTicksInYear(daysInMonth: number)`{: .language-javascript .m-link #ticks-in-year }: Returns the number of calendar ticks in a year for the provided number of days in a month
- `.getTotalMinutes(time: number)`{: .language-javascript .m-link #total-minutes }: Returns the number of minutes in the provided number of ticks
- `.getTotalHours(time: number)`{: .language-javascript .m-link #total-hours }: Returns the number of hours in the provided number of ticks
- `.getTotalDays(time: number)`{: .language-javascript .m-link #total-days }: Returns the number of days in the provided number of ticks
- `.getTotalMonths(time: number, daysInMonth: number)`{: .language-javascript .m-link #total-months }: Returns the number of months in the provided number of ticks and days in a month
- `.getTotalYears(time: number, daysInMonth: number)`{: .language-javascript .m-link #total-years }: Returns the number of years in the provided number of ticks and days in a month
- `.getMinuteOfHour(time: number)`{: .language-javascript .m-link #minute-of-hour }: Returns the minute of the hour for the given tick
- `.getHourOfDay(time: number)`{: .language-javascript .m-link #hour-of-day }: Returns the hour of the day for the given tick
- `.getDayOfMonth(time: number, daysInMonth: number)`{: .language-javascript .m-link #day-of-month }: Returns the day of the month for the given tick and number of days in a month
- `.getMonthOfYear(time: number, daysInMonth: number)`{: .language-javascript .m-link #month-of-year }: Returns the month of the year for the given tick and number of days in a month
- `.getFractionOfMonth(time: number, daysInMonth: number)`{: .language-javascript .m-link #fraction-of-month }: Returns the fraction, in the range [0, 1], of the month for the given tick and number of days in a month
- `.getFractionOfYear(time: number, daysInMonth: number)`{: .language-javascript .m-link #fraction-of-year }: Returns the fraction, in the range [0, 1], of the year for the given tick and number of days in a month
- `.getTimeAndDate(time: number, daysInMonth: number)`{: .language-javascript .m-link #time-and-date-0 }: Returns a `MutableComponent` describing the date and time from the given number of ticks and days in a month
- `.getTimeAndDate(hour: number, minute: number, month: Month, day: number, years: number)`{: .language-javascript .m-link #.m-link #-1 }: Returns a `MutableComponent` describing the date and time from the given hour, minute, month, day, and year
- `.getTimeDelta(ticks: number, daysInMonth: number)`{: .language-javascript .m-link #time-delta }: Returns a `MutableComponent` describing the time delta of the given number of ticks and days in a month

# ICalendar

A `ICalendar` is an object which keeps track of time, TFC has one for the client and one for the server which have different purposes, but they both have access to a common set of values

## Method Signatures

```js
cal.getTicks(): number
cal.getCalendarTicks(): number
cal.getCalendarDaysInMonth(): number
cal.ticksToCalendarTicks(tick: number): number
cal.getTotalHours(): number
cal.getTotalCalendarHours(): number
cal.getTotalDays(): number
cal.getTotalCalendarDays(): number
cal.getTotalMonths(): number
cal.getTotalCalendarMonths(): number
cal.getTotalYears(): number
cal.getTotalCalendarYears(): number
cal.getCalendarDayTime(): number
cal.getCalendarDayOfMonth(): number
cal.getCalendarFractionOfMonth(): number
cal.getCalendarFractionOfYear(): number
cal.getCalendarDayOfYear(): MutableComponent
cal.getCalendarMonthOfYear(): Month
cal.getCalendarTicksInMonth(): number
cal.getCalendarTicksInYear(): number
cal.getCalendarTimeAndDate(): MutableComponent
cal.getTimeDelta(ticks: number): MutableComponent
```

- `.getTicks()`{: .language-javascript .m-link #calendar-ticks }: Returns the absolute number of time since the world was created. Safe to store timestamps with
- `.getCalendarTicks()`{: .language-javascript .m-link #calendar-calendar-ticks }: Returns the number of ticks since Jan 1, 1000
- `.getCalendarDaysInMonth()`{: .language-javascript .m-link #calendar-days-in-month }: Returns the number of days in a month
- `.ticksToCalendarTicks(tick: number)`{: .language-javascript .m-link #calendar-ticks-to-calendar-ticks }: Returns the corresponding calendar tick of the given tick
- `.getTotalHours()`{: .language-javascript .m-link #calendar-total-hours }: Returns the total amount of hours passed
- `.getTotalCalendarHours()`{: .language-javascript .m-link #calendar-total-calendar-hours }: Returns the total amount of hours passed since Jan 1, 1000
- `.getTotalDays()`{: .language-javascript .m-link #calendar-total-days }: Returns the total number of days passed
- `.getTotalCalendarDays()`{: .language-javascript .m-link #calendar-total-calendar-days }: Returns the total number of days passed since Jan 1, 1000
- `.getTotalMonths()`{: .language-javascript .m-link #calendar-total-months }: Returns the total number of months passed
- `.getTotalCalendarMonths()`{: .language-javascript .m-link #calendar-total-calendar-months }: Returns the total number of months passed since Jan 1, 1000
- `.getTotalYears()`{: .language-javascript .m-link #calendar-total-years }: Returns the total number of years passed
- `.getTotalCalendarYears()`{: .language-javascript .m-link #calendar-total-calendar-years }: Returns the total number of years passed since Jan 1, 1000
- `.getCalendarDayTime()`{: .language-javascript .m-link #calendar-day-time }: Returns the time of day, in the range [0, 24000), should match `Level#getDayTime()`
- `.getCalendarDayOfMonth()`{: .language-javascript .m-link #calendar-day-of-month }: Returns the day of the month from the calendar time
- `.getCalendarFractionOfMonth()`{: .language-javascript .m-link #calendar-fraction-of-month }: Returns the progress, in the range [0, 1] through the month from the calendar time
- `.getCalendarFractionOfYear()`{: .language-javascript .m-link #calendar-fraction-of-year }: Returns the progress through the year, in the range [0, 1] from the calendar time, where Jan 1 = 0
- `.getCalendarDayOfYear()`{: .language-javascript .m-link #calendar-day-of-year }: Returns a `MutableComponent` describing the current day of the week from the calendar time
- `.getCalendarMonthOfYear()`{: .language-javascript .m-link #calendar-month-of-year }: Returns the month of the year from the calendar time
- `.getCalendarTicksInMonth()`{: .language-javascript .m-link #calendar-ticks-in-month }: Returns the total number of ticks in a month
- `.getCalendarTicksInYear()`{: .language-javascript .m-link #calendar-ticks-in-year }: Returns the total number of ticks in a year
- `.getCalendarTimeAndDate()`{: .language-javascript .m-link #calendar-time-and-date }: Returns a `MutableComponent` describing the current timestamp formatted like: `00:00 January 1, 1000` in base TFC
- `.getTimeDelta(ticks: number)`{: .language-javascript .m-link #calendar-time-delta }: Returns a `MutableComponent` describing the time delta of the provided number of ticks
