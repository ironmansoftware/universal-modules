import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import FullCalendar from '@fullcalendar/react'
import dayGridPlugin from '@fullcalendar/daygrid'
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
            plugins={[dayGridPlugin, interactionPlugin]}
            initialView="dayGridMonth"
            events={props.events}
            dateClick={dateClicked}
        />
    )
}

export default withComponentFeatures(UDComponent)