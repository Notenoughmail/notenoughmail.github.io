---
layout: page
title: Calendar Bindings
permalink: /kubejs_tfc/1.21.1/bindings/calendar/
parent: Bindings
grand_parent: 1.21.1
desc: Bindings for using and retrieving TFC's calendar system
field: calendar
---

# {{ page.title }}

{{ page.desc }}

```js-21
declare class CalendarBindings {

    // These can be accessed via TFC.calendar.*

    HOURS_IN_DAY: int // 24
    MONTHS_IN_YEAR: int // 12
    CALENDAR_TICKS_IN_HOUR: int // 1000
    CALENDAR_TICKS_IN_DAY: int // 24000

    getCalendar(): ICalendar
    getCalendar(level: LevelReader): ICalendar
    getCalendar(isClient: boolean): ICalendar
    getCalendar(entity: Entity): ICalendar
    getCalendar(be: BlockEntity): ICalendar
    
    getTimeAndDate(calendarTick: int, daysInMonth: int): MutableComponent
    getDayTime(calendarTick: int): MutableComponent
    getTimeDelta(calendarTicks: int, daysInMonth: int): MutableComponent

    getTotalCalendarDays(calendarTick: int): int

    getMonthOfYear(calendarTick: int, daysInMonth: int): Month
}
```

- `.getCalendar(_?: (LevelReader | boolean | Entity | BlockEntity))`{: .language-kube-21 #get-calendar }: Gets the server or client [`ICalendar`]({% link kubejs_tfc/1.21.1/type-explanations.md %}#icalendar) from the given object
- `.getTimeAndDate(calendarTick: int, daysInMonth: int)`{: .language-kube-21 #get-time-and-date }: Creates a formatted text object that describes the given calendar tick's date and time in `HH:MM month DD, YYY` format
- `.getDayTime(calendarTick: int)`{: .language-kube-21 #get-day-time }: Creates a formatted text object that describes the calendar tick in `HH:MM` form
- `.getTimeDelta(calendarTicks: int, daysInMonth: int)`{: .language-kube-21 #get-time-delta }: Creates a formatted text object describing the amount of time the calendar ticks value represents
- `.getTotalCalendarDays(calendarTick: int)`{: .language-kube-21 #get-total-calendar-days }: Returns the number of calendar days which have passed since the start of the world at the given calendar tick
- `.getMonthOfYear(calendarTick: int, daysInMonth: int)`{: .language-kube-21 #get-month-of-year }: Gets the month at the given calendar tick
