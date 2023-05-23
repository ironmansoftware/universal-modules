import React from 'react';
import { h } from 'preact';
import { withComponentFeatures } from 'universal-dashboard'
import FullCalendar from '@fullcalendar/react'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import multimonthPlugin from '@fullcalendar/multimonth'
import listPlugin from '@fullcalendar/list'
import interactionPlugin from '@fullcalendar/interaction';

import allLocales from '@fullcalendar/core/locales-all';

const UDComponent = props => {

    const dateClicked = (arg) => {
        if (props.dateClicked == null) return
        props.dateClicked({
            date: arg.date,
            allDay: arg.allDay,
            dateStr: arg.dateStr
        })
    }

    const eventClicked = (arg) => {
        if (props.eventClicked == null) return
        props.eventClicked(arg.event)
    }

    const renderEventContent = (arg) => {
        if (arg.event.extendedProps.content) {
            return props.render(arg.event.extendedProps.content)
        }
        return <i style={{ cursor: "pointer" }}>{arg.event.title}</i>
    }

    return (
        <FullCalendar
            plugins={[
                dayGridPlugin,
                interactionPlugin,
                timeGridPlugin,
                listPlugin,
                multimonthPlugin
            ]}
            locales={allLocales}
            locale={props.locale || 'en-us'}
            initialView={props.view}
            events={props.events}
            dateClick={dateClicked}
            weekends={props.weekends}
            hiddenDays={props.hiddenDays}
            dayHeaders={props.dayHeaders}
            initialDate={props.initialDate}
            eventContent={renderEventContent}
            eventClick={eventClicked}
        />
    )
}

export default withComponentFeatures(UDComponent)