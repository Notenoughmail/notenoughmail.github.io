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

```js-20
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

- `.getCalendar()`{: .language-kube-20 #calendar-0 }: Returns either the server or client [ICalendar](#icalendar) object, a best guess attempt is made to determine which is returned
- `.getCalendar(isClientSide: boolean)`{: .language-kube-20 #calendar-1 }: Returns either the server, if false, or client, if true, [ICalendar](#icalendar)
- `.getCalendar(level: LevelReader)`{: .language-kube-20 #calendar-2 }: Returns the level's [ICalendar](#icalendar)
- `.getCalendar(entity: Entity)`{: .language-kube-20 #calendar-3 }: Returns the entity's level's [ICalendar](#icalendar)
- `.getCalendar(be: BlockEntity)`{: .language-kube-20 #calendar-4 }: Returns the block entity's level's [ICalendar](#icalendar), if present, else the the best guess on the appropriate calendar
- `.getCalendarTicksInMonth(daysInMonth: number)`{: .language-kube-20 #ticks-in-month }: Returns the number of calendar ticks in a month for the provided number of days in a month
- `.getCalendarTicksInYear(daysInMonth: number)`{: .language-kube-20 #ticks-in-year }: Returns the number of calendar ticks in a year for the provided number of days in a month
- `.getTotalMinutes(time: number)`{: .language-kube-20 #total-minutes }: Returns the number of minutes in the provided number of ticks
- `.getTotalHours(time: number)`{: .language-kube-20 #total-hours }: Returns the number of hours in the provided number of ticks
- `.getTotalDays(time: number)`{: .language-kube-20 #total-days }: Returns the number of days in the provided number of ticks
- `.getTotalMonths(time: number, daysInMonth: number)`{: .language-kube-20 #total-months }: Returns the number of months in the provided number of ticks and days in a month
- `.getTotalYears(time: number, daysInMonth: number)`{: .language-kube-20 #total-years }: Returns the number of years in the provided number of ticks and days in a month
- `.getMinuteOfHour(time: number)`{: .language-kube-20 #minute-of-hour }: Returns the minute of the hour for the given tick
- `.getHourOfDay(time: number)`{: .language-kube-20 #hour-of-day }: Returns the hour of the day for the given tick
- `.getDayOfMonth(time: number, daysInMonth: number)`{: .language-kube-20 #day-of-month }: Returns the day of the month for the given tick and number of days in a month
- `.getMonthOfYear(time: number, daysInMonth: number)`{: .language-kube-20 #month-of-year }: Returns the month of the year for the given tick and number of days in a month
- `.getFractionOfMonth(time: number, daysInMonth: number)`{: .language-kube-20 #fraction-of-month }: Returns the fraction, {% in_unit %}, of the month for the given tick and number of days in a month
- `.getFractionOfYear(time: number, daysInMonth: number)`{: .language-kube-20 #fraction-of-year }: Returns the fraction, {% in_unit %}, of the year for the given tick and number of days in a month
- `.getTimeAndDate(time: number, daysInMonth: number)`{: .language-kube-20 #time-and-date-0 }: Returns a `MutableComponent` describing the date and time from the given number of ticks and days in a month
- `.getTimeAndDate(hour: number, minute: number, month: Month, day: number, years: number)`{: .language-kube-20 #.m-link #-1 }: Returns a `MutableComponent` describing the date and time from the given hour, minute, month, day, and year
- `.getTimeDelta(ticks: number, daysInMonth: number)`{: .language-kube-20 #time-delta }: Returns a `MutableComponent` describing the time delta of the given number of ticks and days in a month

# ICalendar

A `ICalendar` is an object which keeps track of time, TFC has one for the client and one for the server which have different purposes, but they both have access to a common set of values

## Method Signatures

```js-20
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

- `.getTicks()`{: .language-kube-20 #calendar-ticks }: Returns the absolute number of time since the world was created. Safe to store timestamps with
- `.getCalendarTicks()`{: .language-kube-20 #calendar-calendar-ticks }: Returns the number of ticks since Jan 1, 1000
- `.getCalendarDaysInMonth()`{: .language-kube-20 #calendar-days-in-month }: Returns the number of days in a month
- `.ticksToCalendarTicks(tick: number)`{: .language-kube-20 #calendar-ticks-to-calendar-ticks }: Returns the corresponding calendar tick of the given tick
- `.getTotalHours()`{: .language-kube-20 #calendar-total-hours }: Returns the total amount of hours passed
- `.getTotalCalendarHours()`{: .language-kube-20 #calendar-total-calendar-hours }: Returns the total amount of hours passed since Jan 1, 1000
- `.getTotalDays()`{: .language-kube-20 #calendar-total-days }: Returns the total number of days passed
- `.getTotalCalendarDays()`{: .language-kube-20 #calendar-total-calendar-days }: Returns the total number of days passed since Jan 1, 1000
- `.getTotalMonths()`{: .language-kube-20 #calendar-total-months }: Returns the total number of months passed
- `.getTotalCalendarMonths()`{: .language-kube-20 #calendar-total-calendar-months }: Returns the total number of months passed since Jan 1, 1000
- `.getTotalYears()`{: .language-kube-20 #calendar-total-years }: Returns the total number of years passed
- `.getTotalCalendarYears()`{: .language-kube-20 #calendar-total-calendar-years }: Returns the total number of years passed since Jan 1, 1000
- `.getCalendarDayTime()`{: .language-kube-20 #calendar-day-time }: Returns the time of day, {% in_range 0,24000,) %}, should match `Level#getDayTime()`
- `.getCalendarDayOfMonth()`{: .language-kube-20 #calendar-day-of-month }: Returns the day of the month from the calendar time
- `.getCalendarFractionOfMonth()`{: .language-kube-20 #calendar-fraction-of-month }: Returns the progress, {% in_unit %} through the month from the calendar time
- `.getCalendarFractionOfYear()`{: .language-kube-20 #calendar-fraction-of-year }: Returns the progress through the year, {% in_unit %} from the calendar time, where Jan 1 = 0
- `.getCalendarDayOfYear()`{: .language-kube-20 #calendar-day-of-year }: Returns a `MutableComponent` describing the current day of the week from the calendar time
- `.getCalendarMonthOfYear()`{: .language-kube-20 #calendar-month-of-year }: Returns the month of the year from the calendar time
- `.getCalendarTicksInMonth()`{: .language-kube-20 #calendar-ticks-in-month }: Returns the total number of ticks in a month
- `.getCalendarTicksInYear()`{: .language-kube-20 #calendar-ticks-in-year }: Returns the total number of ticks in a year
- `.getCalendarTimeAndDate()`{: .language-kube-20 #calendar-time-and-date }: Returns a `MutableComponent` describing the current timestamp formatted like: `00:00 January 1, 1000` in base TFC
- `.getTimeDelta(ticks: number)`{: .language-kube-20 #calendar-time-delta }: Returns a `MutableComponent` describing the time delta of the provided number of ticks
