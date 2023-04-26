import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import FullCalendar from '@fullcalendar/react'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import multimonthPlugin from '@fullcalendar/multimonth'
import listPlugin from '@fullcalendar/list'
import interactionPlugin from '@fullcalendar/interaction';

const UDComponent = props => {

    const dateClicked = (arg) => {
        if (props.dateClicked == null) return
        props.dateClicked({
            date: arg.date,
            allDay: arg.allDay,
            dateStr: arg.dateStr
        })
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
            initialView={props.view}
            events={props.events}
            dateClick={dateClicked}
            weekends={props.weekends}
            hiddenDays={props.hiddenDays}
            dayHeaders={props.dayHeaders}
            initialDate={props.initialDate}
        />
    )
}

export default withComponentFeatures(UDComponent)