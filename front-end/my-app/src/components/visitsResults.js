import React, {useEffect} from 'react';
import moment from 'moment';
import {
    makeStyles,
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableRow,
    Paper,
    Toolbar,
    Typography
} from "@material-ui/core";
import axios from "axios";
import NavBar from "./NavBar";

const useStyles = makeStyles(theme => ({
    root: {
        //width: '100%',
        paddingLeft: 40,
        paddingRight: 40,
        paddingTop: 20,
        paddingBottom: 40
    },
    paper: {
        marginTop: theme.spacing(1),
        //width: '100%',
        overflowX: 'auto',
        marginBottom: theme.spacing(1),
    },
    table: {
        //width: 330,
    },
    bar: {
        justifyContent: 'center',
    },
}));

const SPTable = ({list}) => {

    const classes = useStyles();

    return (
        <div className={classes.root}>
            <Paper className={classes.paper} elevation={9}>
                <Toolbar className={classes.bar}>
                    <Typography variant="h5">Visits </Typography>
                </Toolbar>
                <Table className={classes.table} size="small">
                    <TableHead>
                        <TableRow>
                            <TableCell align='left'><b>Room ID</b></TableCell>
                            <TableCell align='left'><b>Position</b></TableCell>
                            <TableCell align='left'><b>Service</b></TableCell>
                            <TableCell align='left'><b>Time of Entrance</b></TableCell>
                            <TableCell align='left'><b>Time of Exit</b></TableCell>
                            <TableCell align='left'><b>Amount of Cost</b></TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {list && list.map(session => (
                            <TableRow key={session.SessionID}>
                                <TableCell>{session.hotel_room_ID}</TableCell>
                                <TableCell>{session.description_of_position}</TableCell>
                                <TableCell>{session.service_description}</TableCell>
                                <TableCell>{moment(new Date(session.date_time_of_entrance)).format("HH:mm:ss.SSS A on D MMM YYYY")}</TableCell>
                                <TableCell>{moment(new Date(session.date_time_of_exit)).format("HH:mm:ss.SSS A on D MMM YYYY")}</TableCell>
                                <TableCell>{session.amount}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </Paper>
        </div>
    );
}

export default function SessionPerProviderTable() {
    const path = window.location.pathname;

    const mak = path.split('/')
    const serviceId = mak[2]  //path.substring(21, path.length - 18);
    const cost = mak[3]
    const dateFrom = mak[4]//mak[4].substring(0,3) + '-' + mak[4].substring(4,5) + '-' + mak[4].substring(6,7) //path.substring(path.length - 17, path.length - 9);
    const dateTo = mak[5]//path.substring(path.length - 8, path.length);
    const token = 0//localStorage.getItem("access-token").toString().replace(/['"]+/g, '');

    const [data, setData] = React.useState(
        [
            {
                hotel_room_ID: serviceId,
                description_of_position: '',
                service_description: '',
                date_time_of_entrance: '',
                date_time_of_exit: '',
                amount: cost,
                //FinishedOn: '',
                //EnergyDelivered: 0.0,
                //PricePolicyRef: 0,
                //CostPerKWh: 0.0,
                //TotalCost: 0.0,
            }
        ]
    );

    useEffect(() => {
        loadData();
    }, [])

    const loadData = async () => {

        const url = 'http://localhost:8765/db/api/servicesCriteria/' + serviceId + '/' + cost + '/' + dateFrom + '/' + dateTo;
        axios.get(url, {
            headers: {
                'x-observatory-auth': token
            }
        }).then(response => {
            setData(response.data);
        })
    }

    return (
        <div>
            <NavBar/>
            <SPTable list={data}/>
        </div>
    )
}