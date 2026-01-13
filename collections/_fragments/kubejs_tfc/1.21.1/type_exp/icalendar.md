---
layout: none
s: icalendar
title: '`ICalendar`'
anchor: icalendar
cat:
    - kubejs_tfc
    - 1.21.1
    - type_exp
---

A calendar instance that holds information about the world time and TFC's system of tracking ticks. `ICalendar`s can be retrieved via the [`TFC.calendar`{:.language-kube-21}]({% link kubejs_tfc/1.21.1/bindings/calendar.md %}#get-calendar) sub-binding. Calendars have two internal tick counts

- `playerTicks`, or simply `ticks`, are a monotonic, constantly increasing count of how many ticks have passed since the world began. They are global across dimensions and not synced with the day/night cycle. These should be used for saving/comparing timestamps
- `calendarTicks` are a representation of the seasonal and daytime calendar and may pause or be reversed. These are never safe to use as timestamps

Calendars have several methods from which time information can be gotten

- `.getTicks(): int`{: .language-kube-21 #{{ page.anchor }}-get-ticks }: Get the absolute amount of ticks passed since the world was created, pausing only when players are offline. Safe to use for calendar timestamps
- `.getTicksInHour(): int`{: .language-kube-21 #{{ page.anchor }}-get-ticks-in-hour }: Get the number of ticks in a single *calendar* tick hour
- `.getCalendarTicks(): int`{: .language-kube-21 #{{ page.anchor }}-get-calendar-ticks }: Get the number of ticks since Jan 1, 1000
- `.getCalendarDaysInMonth(): int`{: .language-kube-21 #{{ page.anchor }}-get-calendar-days-in-month }: Get the number of days in a month
- `.getCalendarTickFromOffset(offsetTick: int): int`{: .language-kube-21 #{{ page.anchor }}-get-calendar-tick-from-offset }: Get the expected calendar tick after the given player tick offset
- `.getFixedCalendarTicksFromTick(offsetTick: int): int`{: .language-kube-21 #{{ page.anchor }}-get-fixed-calendar-ticks-from-tick }: Get the expected calendar ticks (duration) represented by the player tick offset. This should be independent with respect to time, but should not be used for incrementing from a calendar tick, use [`.getCalendarTickFromOffset(int)`{:.language-kube-21}](#{{ page.anchor }}-get-calendar-tick-from-offset){:.preserve-color} for that instead
- `.getTotalCalendarDays(): int`{: .language-kube-21 #{{ page.anchor }}-get-total-calendar-days }: Get the total amount of days passed since Jan 1, 1000
- `.getCalendarYear(): int`{: .language-kube-21 #{{ page.anchor }}-get-calendar-year }: Get the display year, starting at 1000
- `.getCalendarDayOfMonth(): int`{: .language-kube-21 #{{ page.anchor }}-get-calendar-day-of-month }: Get the numeric day of the month
- `.getCalendarFractionOfHour(): number`{: .language-kube-21 #{{ page.anchor }}-get-calendar-fraction-of-hour }: Get the fractional progress, {% in_unit %}, of the current hour
- `.getCalendarFractionOfDay(): number`{: .language-kube-21 #{{ page.anchor }}-get-calendarFractionOfDay }: Get the fractional progress, {% in_unit %}, of the current day, where `0`{:.n} indicates midnight and `0.5`{:.n} is noon
- `.getCalendarFractionOfMonth(): number`{: .language-kube-21 #{{ page.anchor }}-get-calendar-fraction-of-month }: Get the fraction progress, {% in_unit %}, of the current month
- `.getCalendarFractionOfYear(): number`{: .language-kube-21 #{{ page.anchor }}-get-calendar-fraction-of-year }: Get the fraction progress, {% in_unit %}, of the current year
- `.getCalendarDayOfYear(): MutableComponent`{: .language-kube-21 #{{ page.anchor }}-get-calendarDay-of-year }: Get a text component representation of the current day
- `.getBirthDay(): MutableComponent`{: .language-kube-21 #{{ page.anchor }}-get-birthday }: Get a text component of the current birthday, or an empty component if none
- `.getHemisphericalCalendarMonthOfYear(northernHemisphere: boolean): Month`{: .language-kube-21 #{{ page.anchor }}-get-hemispherical-calendar-month-of-year-0 }: Get the current [`Month`{:.e}](#month-enum){:.preserver-color} of the 'seasonal year' for a hemisphere
- `.getHemisphericalCalendarMonthOfYear(northernHemisphere: boolean, calendarTicks: int, daysInMonth: int): Month`{: .language-kube-21 #{{ page.anchor }}-get-hemispherical-calendar-month-of-year-1 }: Get the [`Month`{:.e}](#month-enum){:.preserve-color} of the 'seasonal year' for the hemisphere and calendar tick
- `.getAbsoluteCalendarMonthOfYear(): Month`{: .language-kube-21 #{{ page.anchor }}-get-absolute-calendar-month-of-year }: Get the current [`Month`{:.e}](#month-enum){:.preserve-color} of the year in calendar time. Should be used when displaying a calendar month by name or when using absolute time, rather than time-of-year
- `.getCalendarTicksInMonth(): int`{: .language-kube-21 #{{ page.anchor }}-get-calendar-ticks-in-month }: Get the total number of ticks in a month
- `.getCalendarTicksInYear(): int`{: .language-kube-21 #{{ page.anchor }}-get-calendar-ticks-in-year }: Get the total number of ticks in a year
- `.getTimeAndDate(): MutabelComponent`{: .language-kube-21 #{{ page.anchor }}-get-time-and-date }: Get a text component displaying the current time and date in `HH:MM month DD, YYYY` form
- `.getDayTime(): MutableComponent`{: .language-kube-21 #{{ page.anchor }}-get-day-time }: Get a text component displaying the current time in `HH:MM` form
- `.getHourOfDay(): int`{: .language-kube-21 #{{ page.anchor }}-get-hour-of-day }: Get the current hour of the day, {% in_range 0,23 %}
- `.getMinuteOfHour(): int`{: .language-kube-21 #{{ page.anchor }}-get-minute-of-hour }: Get the current minute of the hour, {% in_range 0, 59 %}
- `.getExactTimeAndDate(playerTick: int): MutableComponent`{: .language-kube-21 #{{ page.anchor }}-get-exact-time-and-date }: Get a text component displaying the given timestamp in `HH:MM month DD, YYYY` form
- `.getOffsetTimeAndDate(offsetTick: int): MutableComponent`{: .language-kube-21 #{{ page.anchor }}-get-offset-time-and-date }: Get a text component displaying the time, in `HH:MM month DD, YYYY` form, at the given player tick offset from now
- `.getTimeDelta(playerTick: int): MutableComponent`{: .language-kube-21 #{{ page.anchor }}-get-time-delta }: Get a text component displaying a time delta of the given number of player ticks
- `.getCalendarTimeDelta(offsetTick: int): MutableComponent`{: .language-kube-21 #{{ page.anchor }}-get-calendar-time-delta }: Get a text component displaying a length of time equal to the given player tick offset
- `.getTimestamp(): int`{: .language-kube-21 #{{ page.anchor }}-get-timestamp }: Get the current timestamp, returns the save value as [`.getTicks()`{:.language-kube-21}](#{{ page.anchor }}-get-ticks){:.preserve-color}
- `.isServerCalendar(): boolean`{: .language-kube-21 #{{ page.anchor }}-is-server-calendar }: If the calendar is for the logical server side
- `.transaction(transaction: Consumer<Transaction>): void`{: .language-kube-21 #{{ page.anchor }}-transaction }: Performs a calendar transaction, allowing the player tick of the calendar to be transiently modified. `Transaction`s have two methods which change the player tick, but only within the callback
    - `.add(ticks: int): void`{:.language-kube-21}: Add a certain amount of ticks to the calendar within the transaction
    - `.ticks(): int`{:.language-kube-21}: Get the total number of ticks that have been added within the transaction

{% comment %}

## month enum

{% endcomment %}
