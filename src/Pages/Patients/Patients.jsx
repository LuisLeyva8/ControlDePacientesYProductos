import NavBar from '../../Components/Navbar/Navbar';
import Cards from '../../Components/cards/Cards-Patients/Cards'
import { PALETTE } from '../../constants/Colors';

const Patients =()=>{
    const colorContainerBackground = PALETTE.secondary; 
    const colorButton = PALETTE.primary;
    return <>
    <NavBar></NavBar>
            <div
    className="
        w-auto 
        pt-8 pb-10 
        my-12 mx-[10%] 
        rounded-md 
        shadow-xl 
        p-6 
    "
    style={{ backgroundColor: colorContainerBackground }}
>
    <div className="flex justify-between items-center mb-6">

        <input 
            type="text" 
            className="
                border-2 border-gray-300 rounded-md bg-white 
                px-4 py-2 w-full max-w-xs focus:outline-none 
                focus:ring-2 focus:ring-blue-500
            " 
            placeholder="Buscar paciente"
        />
        
        <button 
            type="button" 
            className="
                rounded-md 
                px-4 py-2 text-white font-semibold 
                hover:opacity-90 transition duration-150
            "
            style={{ backgroundColor: colorButton }}
        > 
            + Nuevo paciente
        </button>
    </div>
    <div
        className="
            grid 
            grid-cols-2 
            sm:grid-cols-2 
            md:grid-cols-3 
            lg:grid-cols-4 
            gap-6 
        "
    >
        <Cards />
        <Cards />
        <Cards />
        <Cards />
        <Cards />
        <Cards />
    </div>
</div>
    </>
};

export default Patients;